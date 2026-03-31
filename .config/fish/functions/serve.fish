#function serve --description 'Start a simple Python HTTP server (default 8000)'
#    set -l port 8000
#    if test (count $argv) -ge 1
#        set port $argv[1]
#    end
#
#    echo "Serving on port $port"
#    python3 -m http.server "$port"
#end

function serve --description 'Start updog file server with intelligent port selection'
    # Parse arguments
    argparse 'p/port=' 'd/directory=' 'h/help' -- $argv
    or return 1
    
    # Show help
    if set -q _flag_help
        echo "Usage: serve [OPTIONS]"
        echo ""
        echo "Options:"
        echo "  -p, --port PORT        Port to bind to (default: 9090)"
        echo "  -d, --directory DIR    Directory to serve (default: current)"
        echo "  -h, --help            Show this help message"
        return 0
    end
    
    # Set defaults
    set -l port 9090
    set -l directory (pwd)
    
    # Override with custom port if provided
    if set -q _flag_port
        set port $_flag_port
    end
    
    # Override with custom directory if provided
    if set -q _flag_directory
        set directory $_flag_directory
    end
    
    # Validate directory exists
    if not test -d $directory
        set_color red
        echo "Error: Directory '$directory' does not exist"
        set_color normal
        return 1
    end
    
    # Check if updog is installed
    if not command -q updog
        set_color yellow
        echo "updog not found. Attempting to install..."
        set_color normal
        
        if command -q pipx
            command pipx install updog
        else if command -q pip3
            command pip3 install updog --break-system-packages
        else if command -q pip
            command pip install updog --break-system-packages
        else
            set_color red
            echo "Error: No pip installation found. Cannot install updog."
            set_color normal
            return 1
        end
        
        # Verify installation succeeded
        if not command -q updog
            set_color red
            echo "Error: updog installation failed"
            set_color normal
            return 1
        end
    end
    
    # Check if port is already in use
    if command -q lsof
        if command lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1
            set_color yellow
            echo "Warning: Port $port is already in use"
            set_color normal
            
            # Find next available port
            set -l new_port (math $port + 1)
            while command lsof -Pi :$new_port -sTCP:LISTEN -t >/dev/null 2>&1
                set new_port (math $new_port + 1)
                if test $new_port -gt 65535
                    set_color red
                    echo "Error: Could not find available port"
                    set_color normal
                    return 1
                end
            end
            
            set_color green
            echo "Using port $new_port instead"
            set_color normal
            set port $new_port
        end
    end
    
    # Display startup info
    set_color green
    echo "Starting updog file server..."
    set_color normal
    echo "  Directory: $directory"
    echo "  Port:      $port"
    echo "  URL:       http://localhost:$port"
    echo ""
    
    # CRITICAL: Use 'command' to call the actual updog binary
    command updog -p $port -d $directory
end
