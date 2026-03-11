set -g fish_greeting
bind --erase \cv
if status is-interactive
    if not set -q __fastfetch_done
        set -g __fastfetch_done 1
        fastfetch
    end
end
