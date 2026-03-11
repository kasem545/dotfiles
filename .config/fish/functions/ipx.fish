function ipx --description 'Show IPv4 addresses by interface (or all up)'
    if test (count $argv) -ge 1
        set -l dev $argv[1]
        ip -4 -o addr show dev "$dev" 2>/dev/null | awk '{print $2, $4}' | cut -d/ -f1 | column -t
    else
        ip -4 -o addr show up | awk '{print $2, $4}' | cut -d/ -f1 | column -t
    end
end
