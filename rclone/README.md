# Rclone Backup (systemd user timer)

This setup runs an `rclone-backup.service` on a schedule using `rclone-backup.timer`.
It is configured as a **user** systemd service, so it runs under your account (not root).

## Reload, Enable, and Start

Use these commands after adding or updating the service/timer files:

```bash
# Reload systemd user units to pick up new/changed files
systemctl --user daemon-reload

# Enable timer so it starts automatically on login
systemctl --user enable rclone-backup.timer

# Start timer immediately
systemctl --user start rclone-backup.timer

# Verify timer status
systemctl --user status rclone-backup.timer

# Show all user timers and next trigger times
systemctl --user list-timers
```

## Run Backup Manually

You can trigger a backup anytime without waiting for the timer:

```bash
systemctl --user start rclone-backup.service
```

## View Logs

Check service logs with `journalctl`:

```bash
# Follow live output
journalctl --user -u rclone-backup.service -f

# Show recent log lines from last runs
journalctl --user -u rclone-backup.service -n 50
```

If your backup script writes to a log file, you can inspect it directly:

```bash
cat ~/.local/share/rclone-backup/backup-2026-05-18.log
```

## Quick Troubleshooting

```bash
# Check that both units are visible to systemd
systemctl --user list-unit-files | grep rclone-backup

# Inspect detailed timer properties
systemctl --user show rclone-backup.timer

# Inspect detailed service properties
systemctl --user show rclone-backup.service
```

If the timer is enabled but not running, run `systemctl --user daemon-reload` and start the timer again.
