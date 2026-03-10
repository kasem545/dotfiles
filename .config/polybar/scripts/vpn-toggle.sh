#!/bin/bash

# Toggle VPN connection
# Modify this script according to your VPN setup (OpenVPN, WireGuard, etc.)

if ip link show tun0 &>/dev/null; then
    # VPN is running, disconnect
    sudo killall openvpn
    notify-send "VPN" "Disconnected" -i network-vpn
else
    # VPN is not running, connect
    # Replace with your VPN config path
    sudo openvpn --config /path/to/your/vpn.ovpn --daemon
    notify-send "VPN" "Connecting..." -i network-vpn
fi
