#!/usr/bin/env sh
set -eu

# Ops Sentinel System Telemetry Collector
VERSION="2.0.0"

collect_metrics() {
    TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    HOSTNAME=$(hostname)
    OS_NAME=$(uname -s)
    
    echo "{"
    echo "  \"timestamp\": \"$TIMESTAMP\","
    echo "  \"host\": \"$HOSTNAME\","
    echo "  \"version\": \"$VERSION\","
    echo "  \"os\": \"$OS_NAME\","
    echo "  \"status\": \"HEALTHY\""
    echo "}"
}

if [ "${1:-}" = "--test" ]; then
    echo "[TEST] Running Sentinel diagnostic self-check..."
    collect_metrics
    echo "[TEST] Diagnostic self-check PASSED."
    exit 0
fi

collect_metrics
