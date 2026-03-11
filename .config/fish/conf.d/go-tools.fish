# ~/.config/fish/conf.d/go-tools.fish
# ---- Go tool helpers (fish) ----

function gobin --description "Print Go install bin dir (GOBIN if set, else GOPATH/bin)"
    set -l gb (go env GOBIN 2>/dev/null)
    if test -n "$gb"
        echo $gb
    else
        echo (go env GOPATH 2>/dev/null)/bin
    end
end

function go_mods --description "List module paths embedded in binaries (inventory)"
    set -l dir (gobin)
    if test (count $argv) -ge 1
        set dir $argv[1]
    end

    if not test -d "$dir"
        echo "No such dir: $dir" >&2
        return 1
    end

    # Print: <binary>\t<module> then columnize.
    for b in "$dir"/*
        if not test -e "$b"
            continue
        end

        set -l mod (go version -m "$b" 2>/dev/null | awk '$1=="path"{print $2; exit}')
        if test -n "$mod"
            printf "%s\t%s\n" (basename "$b") "$mod"
        end
    end | column -t
end

function go_modof --description "Print embedded module path for a given binary"
    if test (count $argv) -lt 1
        echo "Usage: go_modof <binary|/full/path>" >&2
        return 1
    end

    set -l bin $argv[1]
    set -l path $bin

    # If not absolute path, resolve via PATH
    if not string match -qr '^/' -- "$bin"
        set path (command -v -- "$bin" 2>/dev/null)
    end

    if test -z "$path" -o not -f "$path"
        echo "Binary not found: $bin" >&2
        return 1
    end

    set -l mod (go version -m "$path" 2>/dev/null | awk '$1=="path"{print $2; exit}')
    if test -z "$mod"
        echo "No module metadata in: $path" >&2
        return 2
    end

    echo $mod
end

function goup --description "Update one Go tool by binary name using embedded module path"
    if test (count $argv) -lt 1
        echo "Usage: goup <binary>" >&2
        return 1
    end

    set -l bin $argv[1]
    set -l mod (go_modof "$bin")
    set -l rc $status
    if test $rc -ne 0
        return $rc
    end

    echo "[*] Updating $bin -> $mod@latest"
    go install "$mod"@latest
end

function goupall --description "Update all Go module binaries in a dir (default: gobin)"
    set -l parallel 4
    set -l dir (gobin)

    # Minimal option parsing: -p N, -d DIR
    set -l i 1
    while test $i -le (count $argv)
        switch $argv[$i]
            case '-p'
                set i (math $i + 1)
                if test $i -le (count $argv)
                    set parallel $argv[$i]
                else
                    echo "Usage: goupall [-p parallel] [-d dir]" >&2
                    return 1
                end
            case '-d'
                set i (math $i + 1)
                if test $i -le (count $argv)
                    set dir $argv[$i]
                else
                    echo "Usage: goupall [-p parallel] [-d dir]" >&2
                    return 1
                end
            case '*'
                echo "Usage: goupall [-p parallel] [-d dir]" >&2
                return 1
        end
        set i (math $i + 1)
    end

    if not test -d "$dir"
        echo "No such dir: $dir" >&2
        return 1
    end

    # Collect unique module paths
    set -l mods
    for b in "$dir"/*
        if not test -e "$b"
            continue
        end
        set -l m (go version -m "$b" 2>/dev/null | awk '$1=="path"{print $2; exit}')
        if test -n "$m"
            set -a mods $m
        end
    end

    if test (count $mods) -eq 0
        echo "No updatable Go module binaries found in: $dir" >&2
        return 2
    end

    # Unique modules
    set -l uniq_mods (printf "%s\n" $mods | sort -u)

    set -l n (printf "%s\n" $uniq_mods | wc -l | tr -d ' ')
    echo "[*] Updating $n tools from: $dir (parallel=$parallel)"

    # Use xargs parallel installs
    printf "%s\n" $uniq_mods | xargs -n1 -P"$parallel" -I{} sh -c 'echo "[*] go install {}@latest"; go install "{}@latest"'
end

function goinstall --description "Install/update a Go module path (defaults to @latest)"
    if test (count $argv) -lt 1
        echo "Usage: goinstall <module-path>[@version]" >&2
        return 1
    end

    set -l mod $argv[1]
    if string match -q '*@*' -- "$mod"
        go install "$mod"
    else
        go install "$mod"@latest
    end
end

function go_pathfix --description "Ensure Go bin dir is in PATH for current shell"
    set -l dir (gobin)
    if not contains -- "$dir" $PATH
        set -gx PATH "$dir" $PATH
        echo "[*] Added to PATH: $dir"
    else
        echo "[*] PATH already contains: $dir"
    end
end

function gorm --description "Remove a Go-installed tool (binary) from (gobin)"
    if test (count $argv) -lt 1
        echo "Usage: gorm <binary>" >&2
        return 1
    end

    set -l dir (gobin)
    set -l bin $argv[1]
    set -l target "$dir/$bin"

    if not test -f "$target"
        echo "Binary not found: $target" >&2
        return 1
    end

    # Refuse symlink (safety)
    if test -L "$target"
        echo "Refusing to remove symlink: $target" >&2
        return 2
    end

    rm -f -- "$target"
    set -l rc $status
    if test $rc -ne 0
        echo "Failed to remove: $target" >&2
        return 3
    end

    echo "[+] Removed: $target"
end
