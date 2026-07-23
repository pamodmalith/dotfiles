autoload -U compinit
autoload -U history-substring-search-up
autoload -U history-substring-search-down

# Emacs style keybindings (v for vi mode, e for emacs mode)
bindkey -e

# Move word left/right
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Bind Up and Down arrow keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind Ctrl+P and Ctrl+N to history search
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# Delete character under cursor
bindkey '^[[3~' delete-char

# Delete word backward (Ctrl+Backspace)
bindkey '^H' backward-kill-word

# Delete word forward (Ctrl+Delete)
bindkey '^[[3;5~' kill-word

# Move to beginning and end of line (Home and End keys)
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
