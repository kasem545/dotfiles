#!/usr/bin/env bash

# Display ethernet interface IP
IF="$(ip route show default 0.0.0.0/0 2>/dev/null | awk '{print $5}' | head -n1)"

if [ -z "$IF" ]; then
    echo "󰈂 No Network"
    exit 0
fi

IP="$(ip -4 -o addr show dev "$IF" 2>/dev/null | awk '{print $4}' | cut -d/ -f1)"

if [ -n "$IP" ]; then
    echo "󰈀 $IF $IP"
else
    echo "󰈂 $IF Down"
fi
