eval "$(starship init zsh)"

eval "$(zoxide init zsh)"

source <(fzf --zsh)

eval "$(fnm env --use-on-cd --shell zsh)"
