#!/bin/bash
set -euo pipefail

CONF="/etc/asl3-autolink.conf"
[[ -f "$CONF" ]] || { echo "Missing $CONF"; exit 1; }
# shellcheck disable=SC1090
source "$CONF"

: "${LOCAL_NODE:?}"
: "${TARGET_NODE:?}"
: "${CONNECT_CODE:?}"

CHECK_INTERVAL="${CHECK_INTERVAL:-10}"
BOOT_GRACE="${BOOT_GRACE:-15}"
CONNECT_RETRIES="${CONNECT_RETRIES:-2}"
RETRY_DELAY="${RETRY_DELAY:-2}"

wait_for_asterisk() {
  for _ in {1..120}; do
    asterisk -rx "core show uptime" >/dev/null 2>&1 && return 0
    sleep 1
  done
  return 1
}

is_linked() {
  asterisk -rx "rpt stats ${LOCAL_NODE}" 2>/dev/null | grep -qE "(^|[^0-9])${TARGET_NODE}([^0-9]|$)"
}

do_connect() {
  asterisk -rx "rpt fun ${LOCAL_NODE} ${CONNECT_CODE}${TARGET_NODE}" >/dev/null 2>&1 || true
}

echo "ASL3 AutoLink starting: ${LOCAL_NODE} -> ${TARGET_NODE}"
sleep "${BOOT_GRACE}"

wait_for_asterisk || exit 0

while true; do
  if is_linked; then
    sleep "${CHECK_INTERVAL}"
    continue
  fi

  echo "Link down. Reconnecting ${LOCAL_NODE} -> ${TARGET_NODE}"
  for ((i=1; i<=CONNECT_RETRIES; i++)); do
    do_connect
    sleep "${RETRY_DELAY}"
    is_linked && break
  done

  sleep "${CHECK_INTERVAL}"
done
