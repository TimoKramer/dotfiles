#!/usr/bin/env python3
"""Tray icon showing status of the mailbox.org rclone bisync setup.

States:
    green  - watcher running, last sync OK, no conflicts
    yellow - watcher running, last sync OK, but conflict files present
    red    - watcher not running OR last sync failed
    gray   - unknown (startup)
"""

import os
import subprocess
import threading
import time
from pathlib import Path

import pystray
from PIL import Image, ImageDraw, ImageFont

# --- Config -----------------------------------------------------------------
HOME = Path.home()
LOCAL_DIR = HOME / "Sync"
WATCHER_UNIT = "mailbox-sync-watcher.service"
SYNC_UNIT = "mailbox-sync.service"
LOG_FILE = HOME / ".local/state/mailbox-sync.log"
CHECK_INTERVAL = 10  # seconds
CONFLICT_GLOBS = ("*.conflict1", "*.conflict2", "*.conflict3")
# ----------------------------------------------------------------------------


def _run(cmd):
    return subprocess.run(cmd, capture_output=True, text=True)


def is_watcher_active() -> bool:
    r = _run(["systemctl", "--user", "is-active", WATCHER_UNIT])
    return r.stdout.strip() == "active"


def last_sync_result() -> str:
    """Return 'ok', 'fail', or 'unknown' based on the tail of the log file."""
    if not LOG_FILE.exists():
        return "unknown"
    try:
        # Read last ~4 KB — enough for the last few log lines
        with LOG_FILE.open("rb") as f:
            f.seek(0, os.SEEK_END)
            size = f.tell()
            f.seek(max(0, size - 4096))
            tail = f.read().decode("utf-8", errors="replace")
    except OSError:
        return "unknown"

    # Walk lines bottom-up, look for our own marker lines from mailbox-sync.sh
    for line in reversed(tail.splitlines()):
        if "[ok] bisync fertig" in line:
            return "ok"
        if "[fail] bisync" in line:
            return "fail"
    return "unknown"


def find_conflicts() -> list[Path]:
    if not LOCAL_DIR.exists():
        return []
    found: list[Path] = []
    for pattern in CONFLICT_GLOBS:
        found.extend(LOCAL_DIR.rglob(pattern))
    return found


def last_sync_time() -> str:
    if not LOG_FILE.exists():
        return "never"
    mtime = LOG_FILE.stat().st_mtime
    delta = time.time() - mtime
    if delta < 60:
        return f"{int(delta)}s ago"
    if delta < 3600:
        return f"{int(delta / 60)}m ago"
    if delta < 86400:
        return f"{int(delta / 3600)}h ago"
    return f"{int(delta / 86400)}d ago"


# --- State ------------------------------------------------------------------
class State:
    def __init__(self):
        self.color = "gray"
        self.watcher = False
        self.last_result = "unknown"
        self.conflicts: list[Path] = []
        self.last_seen = "never"

    def refresh(self):
        self.watcher = is_watcher_active()
        self.last_result = last_sync_result()
        self.conflicts = find_conflicts()
        self.last_seen = last_sync_time()

        if not self.watcher or self.last_result == "fail":
            self.color = "red"
        elif self.conflicts:
            self.color = "yellow"
        elif self.last_result == "ok":
            self.color = "green"
        else:
            self.color = "gray"

    def summary(self) -> str:
        parts = []
        parts.append(f"Watcher: {'running' if self.watcher else 'STOPPED'}")
        parts.append(f"Last sync: {self.last_result} ({self.last_seen})")
        if self.conflicts:
            parts.append(f"Conflicts: {len(self.conflicts)}")
        else:
            parts.append("No conflicts")
        return "\n".join(parts)


state = State()


# --- Icon drawing -----------------------------------------------------------
def create_icon(color: str) -> Image.Image:
    size = 64
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    font = None
    for path in [
        "/usr/share/fonts/TTF/DejaVuSans-Bold.ttf",
        "/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf",
        "/usr/share/fonts/noto/NotoSans-Bold.ttf",
    ]:
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


# --- Menu actions -----------------------------------------------------------
def action_sync_now(icon, item):
    # Kick off a one-shot sync via the existing oneshot service
    subprocess.Popen(["systemctl", "--user", "start", SYNC_UNIT])
    # Refresh soon after so the UI reflects the new state
    threading.Timer(5.0, lambda: refresh_once(icon)).start()


def action_open_log(icon, item):
    if LOG_FILE.exists():
        subprocess.Popen(["xdg-open", str(LOG_FILE)])


def action_open_folder(icon, item):
    if LOCAL_DIR.exists():
        subprocess.Popen(["xdg-open", str(LOCAL_DIR)])


def action_show_conflicts(icon, item):
    if state.conflicts:
        # Open the folder containing the first conflict
        subprocess.Popen(["xdg-open", str(state.conflicts[0].parent)])


def refresh_once(icon):
    state.refresh()
    icon.icon = create_icon(state.color)
    icon.title = f"Mailbox Sync\n{state.summary()}"
    icon.update_menu()


def update_loop(icon):
    while getattr(icon, "visible", False):
        refresh_once(icon)
        time.sleep(CHECK_INTERVAL)


def setup(icon):
    icon.visible = True
    threading.Thread(target=update_loop, args=(icon,), daemon=True).start()


# --- Menu -------------------------------------------------------------------
def status_line(text_fn):
    return pystray.MenuItem(lambda item: text_fn(), None, enabled=False)


menu = pystray.Menu(
    status_line(lambda: f"Watcher: {'running' if state.watcher else 'STOPPED'}"),
    status_line(lambda: f"Last sync: {state.last_result} ({state.last_seen})"),
    status_line(
        lambda: (
            f"Conflicts: {len(state.conflicts)}" if state.conflicts else "No conflicts"
        )
    ),
    pystray.Menu.SEPARATOR,
    pystray.MenuItem("Sync now", action_sync_now),
    pystray.MenuItem(
        "Show conflicts",
        action_show_conflicts,
        enabled=lambda item: bool(state.conflicts),
    ),
    pystray.MenuItem("Open sync folder", action_open_folder),
    pystray.MenuItem("Open log", action_open_log),
    pystray.Menu.SEPARATOR,
    pystray.MenuItem("Quit", lambda icon, item: icon.stop()),
)

icon = pystray.Icon("mailbox-sync", create_icon("gray"), "Mailbox Sync", menu)
icon.run(setup)
