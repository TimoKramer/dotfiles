#!/usr/bin/env bash
# mailbox-watcher.sh — beobachtet lokale Verzeichnisse und triggert bei
# Aenderungen einen Sync, mit Debounce damit nicht bei jedem Event gefeuert wird.

set -euo pipefail

WATCH_DIRS=(
    "${HOME}/Sync"
    # Weitere Verzeichnisse hier eintragen, z.B.:
    # "${HOME}/Dokumente/KeePass"
)

SYNC_SCRIPT="${HOME}/.local/bin/mailbox-sync.sh"
DEBOUNCE_SECONDS=3

# Verzeichnisse anlegen falls noch nicht da
for d in "${WATCH_DIRS[@]}"; do
    mkdir -p "$d"
done

# Hintergrund-Debouncer: wartet auf Signal, dann nach Ruhephase Sync ausfuehren
pending_pid=""

trigger_sync() {
    # Alten pending-Sync abbrechen, neuen Timer starten
    if [[ -n "$pending_pid" ]] && kill -0 "$pending_pid" 2>/dev/null; then
        kill "$pending_pid" 2>/dev/null || true
    fi
    (
        sleep "$DEBOUNCE_SECONDS"
        "$SYNC_SCRIPT" || true
    ) &
    pending_pid=$!
}

# inotifywait liefert eine Zeile pro Event; wir triggern bei jeder Zeile.
# -m = monitor (nicht nach erstem Event beenden)
# -r = rekursiv
# -q = quiet
# Events: close_write (Datei fertig geschrieben), moved_to/from, create, delete
inotifywait -m -r -q \
    -e close_write -e moved_to -e moved_from -e create -e delete \
    --exclude '(\.sync\..*|~$|\.swp$|\.tmp$|4913$)' \
    "${WATCH_DIRS[@]}" | while read -r _event; do
    trigger_sync
done
