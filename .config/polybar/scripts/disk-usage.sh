#!/bin/bash

# Disk usage for root partition
usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$usage" -gt 90 ]; then
    echo " $usage%"
elif [ "$usage" -gt 70 ]; then
    echo " $usage%"
else
    echo " $usage%"
fi
