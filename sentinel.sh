#!/usr/bin/env bash
set -euo pipefail

CHECK_INTERVAL=60
DISK_THRESHOLD=90
MEM_THRESHOLD=85

check_disk() {
  local usage
  usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
  if [ "$usage" -ge "$DISK_THRESHOLD" ]; then
    echo "[ALERT] Disk space critical: ${usage}%"
  fi
}

check_memory() {
  local mem_pct
  mem_pct=$(free | awk '/Mem:/ {printf("%.0f", $3/$2 * 100)}')
  if [ "$mem_pct" -ge "$MEM_THRESHOLD" ]; then
    echo "[ALERT] Memory usage critical: ${mem_pct}%"
  fi
}

echo "OpsSentinel started with RAM and Disk monitors."
check_disk
check_memory
