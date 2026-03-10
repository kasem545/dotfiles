#!/usr/bin/env bash
IF="tun0"

ICON_UP="󰖂"
ICON_DOWN="󰌾"

if ! ip link show "$IF" &>/dev/null; then
  echo "%{F#565f89}$ICON_DOWN%{F-}"
  exit 0
fi

IP=$(ip -4 -o addr show dev "$IF" | awk '{print $4}' | cut -d/ -f1)

if [[ -n "$IP" ]]; then
  echo "%{F#bb9af7}$ICON_UP $IF $IP%{F-}"
else
  echo "%{F#565f89}$ICON_DOWN%{F-}"
fi
