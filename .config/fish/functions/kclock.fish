function kclock --description 'Compare local UTC time with DC time via ntpdate -q'
    if test (count $argv) -lt 1
        echo "Usage: kclock <dc_ip_or_name>"
        return 1
    end

    set -l dc $argv[1]

    echo "Local time:  "(date -u '+%Y-%m-%d %H:%M:%S UTC')

    # Grab first 'server' line from ntpdate output (3s timeout)
    set -l line (timeout 3 ntpdate -q "$dc" 2>/dev/null | awk '/server/ {print $0}' | head -n 1)

    if test -n "$line"
        echo "DC time:     $line"
    else
        echo "DC time:     (no response)"
        return 2
    end
end
