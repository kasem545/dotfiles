#!/bin/bash

# Display system information
case $1 in
    --kernel)
        uname -r
        ;;
    --uptime)
        uptime -p | sed 's/up //'
        ;;
    --packages)
        dpkg -l | grep -c '^ii'
        ;;
    *)
        echo "Usage: $0 {--kernel|--uptime|--packages}"
        ;;
esac
