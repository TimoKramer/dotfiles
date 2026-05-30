#!/usr/bin/env python3
"""Mailbox.org rclone bisync — all-in-one.

A single process that does everything the old four units did:
  * runs `rclone bisync` (the actual sync) — was mailbox-sync.sh
  * triggers a sync periodically to pull remote changes — was the timer
  * triggers a sync on local file changes via inotifywait, debounced,
    to push local changes — was mailbox-watcher.sh
  * shows a tray icon reflecting the latest sync result + conflicts — was
    mailbox-sync-tray.py

Because this process runs the sync itself, it learns the result straight
from rclone's exit code — no logfile/journald parsing needed. Everything is
printed to stdout/stderr, which journald captures when run as a
systemd --user service.

States:
    green  - last sync OK, no conflicts
    yellow - last sync OK, but conflict files present
    red    - last sync failed
    gray   - no sync has finished yet
"""

import logging
import shutil
import subprocess
import sys
import threading
import time
from pathlib import Path

import pystray
from PIL import Image, ImageDraw, ImageFont

# --- Config -----------------------------------------------------------------
HOME = Path.home()
LOCAL_DIR = HOME / "Sync"
REMOTE = "mailbox:Userstore"
SYNC_INTERVAL = 120        # seconds between periodic pulls (was the timer)
INITIAL_DELAY = 5          # first sync shortly after start
DEBOUNCE_SECONDS = 3       # quiet period after a local change before syncing
UI_REFRESH = 10            # seconds between tray refreshes ("x ago", conflicts)
CONFLICT_GLOBS = ("*.conflict1", "*.conflict2", "*.conflict3")
WATCH_DIRS = [LOCAL_DIR]
# inotify events to watch (same set the old shell watcher used)
INOTIFY_EVENTS = ("close_write", "moved_to", "moved_from", "create", "delete")
INOTIFY_EXCLUDE = r"(\.sync\..*|~$|\.swp$|\.tmp$|4913$)"
# ----------------------------------------------------------------------------

log = logging.getLogger("mailbox-sync")


# --- Sync runner ------------------------------------------------------------
class Syncer:
    """Owns the one and only rclone bisync worker.

    Triggers from the timer, the watcher and the "Sync now" menu item are
    coalesced: callers just request a sync, and the worker runs them one at a
    time. Any requests that arrive while a sync is running fold into a single
    follow-up run. This replaces the old flock that guarded against the timer
    and watcher overlapping.
    """

    def __init__(self):
        self._wake = threading.Event()
        self.on_change = lambda: None   # set by the tray to refresh on result
        self.last_result = "unknown"    # "ok" | "fail" | "unknown"
        self.last_time = 0.0            # epoch of last finished run

    def request(self):
        self._wake.set()

    def run_forever(self):
        while True:
            self._wake.wait()
            self._wake.clear()
            try:
                self._run_once()
            except Exception:
                # The worker must never die, or triggers would pile up forever.
                log.exception("[fail] bisync worker crashed")
                self.last_result = "fail"
                self.last_time = time.time()
                self.on_change()

    def _run_once(self):
        # --conflict-loser pathname : losing version kept with a suffix (nothing lost)
        # --compare size            : compare files by size only
        # --max-delete 25           : safety net — abort if >25% would be deleted
        # --resilient               : don't give up on small transient errors
        cmd = [
            "rclone", "bisync", str(LOCAL_DIR), REMOTE,
            "--conflict-loser", "pathname",
            "--compare", "size",
            "--max-delete", "25",
            "--resilient",
            "--create-empty-src-dirs",
            "--log-level", "INFO",
        ]
        log.info("[start] bisync")
        try:
            # No capture: rclone's output inherits our stdout/stderr -> journald
            rc = subprocess.run(cmd).returncode
        except FileNotFoundError:
            log.error("[fail] rclone not found on PATH")
            rc = 127

        self.last_time = time.time()
        if rc == 0:
            self.last_result = "ok"
            log.info("[ok] bisync fertig")
        else:
            self.last_result = "fail"
            # Exit 2 means the baseline state is broken — fix manually with --resync.
            log.error("[fail] bisync exit=%s", rc)
        self.on_change()


# --- Triggers ---------------------------------------------------------------
def periodic_loop(syncer: "Syncer"):
    """Pull remote changes on a fixed interval (was mailbox-sync.timer)."""
    time.sleep(INITIAL_DELAY)
    while True:
        syncer.request()
        time.sleep(SYNC_INTERVAL)


def watch_loop(syncer: "Syncer", stop: threading.Event):
    """Trigger a debounced sync on local changes (was mailbox-watcher.sh).

    Streams inotifywait's output and collapses bursts of events into one
    sync once things have been quiet for DEBOUNCE_SECONDS.
    """
    if not shutil.which("inotifywait"):
        log.warning("inotifywait not found — local-change watching disabled "
                    "(install inotify-tools); periodic pull still runs")
        return

    events = []
    for e in INOTIFY_EVENTS:
        events += ["-e", e]
    cmd = ["inotifywait", "-m", "-r", "-q", *events,
           "--exclude", INOTIFY_EXCLUDE, *(str(d) for d in WATCH_DIRS)]

    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, text=True)
    watch_loop.proc = proc  # so quit can terminate it

    debounce: threading.Timer | None = None
    for _line in proc.stdout:
        if stop.is_set():
            break
        if debounce is not None:
            debounce.cancel()
        debounce = threading.Timer(DEBOUNCE_SECONDS, syncer.request)
        debounce.daemon = True
        debounce.start()


watch_loop.proc = None


def find_conflicts() -> list[Path]:
    if not LOCAL_DIR.exists():
        return []
    found: list[Path] = []
    for pattern in CONFLICT_GLOBS:
        found.extend(LOCAL_DIR.rglob(pattern))
    return found


def humanize(epoch: float) -> str:
    if not epoch:
        return "never"
    delta = time.time() - epoch
    if delta < 60:
        return f"{int(delta)}s ago"
    if delta < 3600:
        return f"{int(delta / 60)}m ago"
    if delta < 86400:
        return f"{int(delta / 3600)}h ago"
    return f"{int(delta / 86400)}d ago"


# --- Tray state -------------------------------------------------------------
class State:
    def __init__(self, syncer: "Syncer"):
        self.syncer = syncer
        self.color = "gray"
        self.conflicts: list[Path] = []

    def refresh(self):
        self.conflicts = find_conflicts()
        result = self.syncer.last_result
        if result == "fail":
            self.color = "red"
        elif self.conflicts:
            self.color = "yellow"
        elif result == "ok":
            self.color = "green"
        else:
            self.color = "gray"

    @property
    def last_seen(self) -> str:
        return humanize(self.syncer.last_time)

    def summary(self) -> str:
        parts = [f"Last sync: {self.syncer.last_result} ({self.last_seen})"]
        if self.conflicts:
            parts.append(f"Conflicts: {len(self.conflicts)}")
        else:
            parts.append("No conflicts")
        return "\n".join(parts)


# --- Icon drawing -----------------------------------------------------------
def create_icon(color: str) -> Image.Image:
    size = 64
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    font = None
    for path in (
        "/usr/share/fonts/TTF/DejaVuSans-Bold.ttf",
        "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf",
        "/usr/share/fonts/noto/NotoSans-Bold.ttf",
    ):
        try:
            font = ImageFont.truetype(path, 26)
            break
        except OSError:
            continue
    if font is None:
        font = ImageFont.load_default()

    bbox = draw.textbbox((0, 0), "DAV", font=font)
    tw, th = bbox[2] - bbox[0], bbox[3] - bbox[1]
    x = (size - tw) // 2 - bbox[0]
    y = (size - th) // 2 - bbox[1]
    draw.text((x, y), "DAV", fill=color, font=font)
    return img


# --- Main -------------------------------------------------------------------
def main():
    logging.basicConfig(level=logging.INFO, format="%(message)s", stream=sys.stdout)
    LOCAL_DIR.mkdir(parents=True, exist_ok=True)

    syncer = Syncer()
    state = State(syncer)
    stop = threading.Event()

    def refresh(icon):
        state.refresh()
        icon.icon = create_icon(state.color)
        icon.title = f"Mailbox Sync\n{state.summary()}"
        icon.update_menu()

    def action_sync_now(icon, item):
        syncer.request()

    def action_open_folder(icon, item):
        if LOCAL_DIR.exists():
            subprocess.Popen(["xdg-open", str(LOCAL_DIR)])

    def action_show_conflicts(icon, item):
        if state.conflicts:
            subprocess.Popen(["xdg-open", str(state.conflicts[0].parent)])

    def action_quit(icon, item):
        stop.set()
        if watch_loop.proc is not None:
            watch_loop.proc.terminate()
        icon.stop()

    def status(text_fn):
        return pystray.MenuItem(lambda item: text_fn(), None, enabled=False)

    menu = pystray.Menu(
        status(lambda: f"Last sync: {syncer.last_result} ({state.last_seen})"),
        status(lambda: (f"Conflicts: {len(state.conflicts)}"
                        if state.conflicts else "No conflicts")),
        pystray.Menu.SEPARATOR,
        pystray.MenuItem("Sync now", action_sync_now),
        pystray.MenuItem("Show conflicts", action_show_conflicts,
                         enabled=lambda item: bool(state.conflicts)),
        pystray.MenuItem("Open sync folder", action_open_folder),
        pystray.Menu.SEPARATOR,
        pystray.MenuItem("Quit", action_quit),
    )

    icon = pystray.Icon("mailbox-sync", create_icon("gray"), "Mailbox Sync", menu)

    # Refresh the tray right after each sync finishes.
    syncer.on_change = lambda: refresh(icon)

    def ui_loop():
        while not stop.is_set():
            refresh(icon)
            time.sleep(UI_REFRESH)

    def setup(icon):
        icon.visible = True
        threading.Thread(target=syncer.run_forever, daemon=True).start()
        threading.Thread(target=periodic_loop, args=(syncer,), daemon=True).start()
        threading.Thread(target=watch_loop, args=(syncer, stop), daemon=True).start()
        threading.Thread(target=ui_loop, daemon=True).start()

    icon.run(setup)


if __name__ == "__main__":
    main()
