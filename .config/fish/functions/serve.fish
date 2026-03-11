function serve --description 'Start a simple Python HTTP server (default 8000)'
    set -l port 8000
    if test (count $argv) -ge 1
        set port $argv[1]
    end

    echo "Serving on port $port"
    python3 -m http.server "$port"
end
