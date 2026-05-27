#!/bin/bash

# ── CONFIG ────────────────────────────────────────────────
REMOTE="gdrive:Backups"
LOG_DIR="$HOME/.local/share/rclone-backup"
LOG_FILE="$LOG_DIR/backup-$(date +%Y-%m-%d).log"
FILTER_FILE="$HOME/.config/rclone/filters.txt"

declare -A SOURCES=(
  ["$HOME/uni"]="FCT"
  ["$HOME/java-uni"]="JIAT"
  ["$HOME/vault"]="Vault"
)
# ── END CONFIG ────────────────────────────────────────────

mkdir -p "$LOG_DIR"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "===== Backup started ====="

if ! ping -c 1 8.8.8.8 &>/dev/null; then
  log "ERROR: No network. Aborting."
  exit 1
fi

for SOURCE in "${!SOURCES[@]}"; do
  DEST="$REMOTE/${SOURCES[$SOURCE]}"

  if [ ! -d "$SOURCE" ]; then
    log "SKIP: $SOURCE does not exist or not mounted"
    continue
  fi

  log "Syncing: $SOURCE → $DEST"

  rclone copy "$SOURCE" "$DEST" \
    --filter-from "$FILTER_FILE" \
    --transfers 6 \
    --checkers 8 \
    --drive-chunk-size 64M \
    --log-file "$LOG_FILE" \
    --log-level INFO \
    --stats 30s \
    -P

  STATUS=$?
  if [ $STATUS -eq 0 ]; then
    log "✓ Done: $SOURCE"
  else
    log "✗ FAILED: $SOURCE (exit code $STATUS)"
  fi
done

log "===== Backup finished ====="

# Delete logs older than 30 days
find "$LOG_DIR" -name "*.log" -mtime +30 -delete
