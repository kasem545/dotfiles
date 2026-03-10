#!/bin/bash

# Bluetooth status
if systemctl is-active --quiet bluetooth.service; then
    devices=$(bluetoothctl devices Connected 2>/dev/null | wc -l)
    if [ "$devices" -gt 0 ]; then
        echo " $devices"
    else
        echo " ON"
    fi
else
    echo " OFF"
fi
