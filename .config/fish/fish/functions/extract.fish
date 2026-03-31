function extract --description 'Extract common archive formats'
    if test (count $argv) -lt 1
        echo "Usage: extract <file>"
        return 1
    end

    set -l file $argv[1]

    if not test -f "$file"
        echo "File not found"
        return 1
    end

    switch $file
        case '*.tar.bz2' '*.tbz2'
            tar xjf "$file"
        case '*.tar.gz' '*.tgz'
            tar xzf "$file"
        case '*.tar'
            tar xf "$file"
        case '*.bz2'
            bunzip2 "$file"
        case '*.rar'
            unrar x "$file"
        case '*.gz'
            gunzip "$file"
        case '*.zip'
            unzip "$file"
        case '*.7z'
            7z x "$file"
        case '*'
            echo "Unknown format"
            return 2
    end
end
