set -g fish_greeting
bind --erase \cv
if status is-interactive
    if not set -q __fastfetch_done
        set -g __fastfetch_done 1
        fastfetch
    end
end

alias l='lsd -l'
alias ls='lsd'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'
