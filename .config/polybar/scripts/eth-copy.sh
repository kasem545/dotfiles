#!/usr/bin/env bash
set -euo pipefail

export DISPLAY="${DISPLAY:-:0}"
export XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}"

# Find interface used for default route
IF="$(ip route show default 0.0.0.0/0 2>/dev/null | awk '{print $5}' | head -n1)"

IP="$(ip -4 -o addr show dev "$IF" 2>/dev/null | awk '{print $4}' | cut -d/ -f1)"

[[ -n "${IP:-}" ]] && printf '%s' "$IP" | xclip -selection clipboard

