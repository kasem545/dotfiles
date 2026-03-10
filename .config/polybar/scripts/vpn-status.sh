#!/bin/bash

# Check if VPN is connected (tun0 interface)
if ip link show tun0 &>/dev/null; then
    ip_addr=$(ip -4 addr show tun0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    echo "VPN: $ip_addr"
else
    echo "VPN: Down"
fi
