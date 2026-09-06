#!/usr/bin/env bash
set -euo pipefail

CHECK_INTERVAL=60
DISK_THRESHOLD=90

check_disk() {
  local usage
  usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
  if [ "$usage" -ge "$DISK_THRESHOLD" ]; then
    echo "[ALERT] Disk space critical: ${usage}%"
  fi
}

echo "OpsSentinel started."
check_disk
