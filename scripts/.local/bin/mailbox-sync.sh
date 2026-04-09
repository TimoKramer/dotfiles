#!/usr/bin/env bash
# mailbox-sync.sh — fuehrt einen rclone bisync-Lauf aus
# Wird aufgerufen vom inotify-Watcher (bei lokalen Aenderungen)
# und vom systemd-Timer (fuer regelmaessigen Pull vom Server)

set -euo pipefail

LOCAL_DIR="${HOME}/Sync"
REMOTE="mailbox:Userstore"
LOCKFILE="/tmp/mailbox-sync.lock"
LOGFILE="${HOME}/.local/state/mailbox-sync.log"

mkdir -p "$(dirname "$LOGFILE")"

# Lock verhindert parallele Laeufe (Watcher + Timer)
exec 9>"$LOCKFILE"
if ! flock -n 9; then
    echo "$(date -Iseconds) [skip] Anderer Sync laeuft bereits" >> "$LOGFILE"
    exit 0
fi

echo "$(date -Iseconds) [start] bisync" >> "$LOGFILE"

# Der eigentliche Sync.
# --conflict-resolve newer : bei Konflikten gewinnt die neuere Datei
# --conflict-loser pathname: verlierende Version wird mit Suffix behalten (nichts geht verloren)
# --max-delete 25          : Sicherheitsnetz — bricht ab, wenn mehr als 25% geloescht wuerden
# --resilient              : bei kleinen Fehlern nicht gleich aufgeben
if rclone bisync "$LOCAL_DIR" "$REMOTE" \
    --conflict-loser pathname \
    --compare size \
    --max-delete 25 \
    --resilient \
    --create-empty-src-dirs \
    --log-file "$LOGFILE" \
    --log-level INFO; then
    echo "$(date -Iseconds) [ok] bisync fertig" >> "$LOGFILE"
else
    rc=$?
    echo "$(date -Iseconds) [fail] bisync exit=$rc" >> "$LOGFILE"
    # Bei Exit 2 ist der Baseline-State kaputt — nur manuell mit --resync fixen.
    exit $rc
fi
