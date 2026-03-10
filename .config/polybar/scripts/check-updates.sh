#!/bin/bash

# Check for available updates on Kali Linux
updates=$(apt list --upgradable 2>/dev/null | grep -c upgradable)

if [ "$updates" -gt 0 ]; then
    echo "$updates"
else
    echo "0"
fi
