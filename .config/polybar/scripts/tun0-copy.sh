#!/usr/bin/env bash
set -euo pipefail

# Make sure we can talk to X even if polybar was started oddly
export DISPLAY="${DISPLAY:-:0}"
export XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}"

IP="$(/usr/bin/ip -4 -o addr show dev tun0 2>/dev/null | /usr/bin/awk '{print $4}' | /usr/bin/cut -d/ -f1)"

# Log what happened (super useful)
LOG="$HOME/.cache/polybar-tun0-copy.log"
mkdir -p "$(dirname "$LOG")"
printf '[%s] DISPLAY=%s XAUTHORITY=%s IP=%s\n' "$(date +'%F %T')" "$DISPLAY" "$XAUTHORITY" "${IP:-<empty>}" >> "$LOG"

if [[ -n "${IP:-}" ]]; then
  printf '%s' "$IP" | /usr/bin/xclip -selection clipboard
fi

