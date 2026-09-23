# =============================================================================
# Aliases imported from Omarchy's default bash (validated & adapted to zsh)
#
# Source: omarchy/default/bash/aliases
# Only tools that are actually installed get aliases; nothing here breaks
# when a tool is missing.
# =============================================================================

# --- File system (eza) ---
# Complements the personal aliases in aliases.zsh (ls/ll/la/cat).
if command -v eza >/dev/null 2>&1; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

# --- Fuzzy file finder (fzf + bat preview) ---
# `ff` = fuzzy-find a file (image preview in kitty, bat preview elsewhere)
# `eff` = open the selected file in $EDITOR
# `sff` = scp the selected file to a destination
if command -v fzf >/dev/null 2>&1; then
  if [[ $TERM == xterm-kitty* ]] && command -v kitty >/dev/null 2>&1; then
    alias ff="fzf --preview 'case \$(file --mime-type -b {}) in image/*) kitty icat --clear --transfer-mode=memory --stdin=no --place=\${FZF_PREVIEW_COLUMNS}x\${FZF_PREVIEW_LINES}@0x0 {} ;; *) bat --style=numbers --color=always {} ;; esac'"
  else
    alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
  fi
  alias eff='$EDITOR "$(ff)"'
  sff() {
    if (( $# == 0 )); then
      echo "Usage: sff <destination> (e.g. sff host:/tmp/)"
      return 1
    fi
    local file
    file=$(find . -type f -printf '%T@\t%p\n' | sort -rn | cut -f2- | ff) && [ -n "$file" ] && scp "$file" "$1"
  }
fi

# --- zoxide-powered cd ---
# `cd <fuzzy match>` jumps via zoxide; plain directories still `cd` directly.
# Only aliased when zoxide is installed so bare `cd` never breaks.
if command -v zoxide >/dev/null 2>&1; then
  alias cd="zd"
  zd() {
    if (( $# == 0 )); then
      builtin cd ~ || return
    elif [[ -d $1 ]]; then
      builtin cd "$1" || return
    else
      if ! z "$@"; then
        echo "Error: Directory not found"
        return 1
      fi
      printf "\U000F17A9 "
      pwd
    fi
  }
fi

# --- Open files/dirs with the default application (detached) ---
open() (
  xdg-open "$@" >/dev/null 2>&1 &
)

# --- Directory shortcuts ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# --- Dev / AI tools (only when the tool is installed) ---
alias c='opencode --auto'
command -v claude >/dev/null 2>&1 && alias cx='printf "\033[2J\033[3J\033[H" && claude --permission-mode auto'
command -v codex >/dev/null 2>&1 && alias cy='codex --approve-for-me'
command -v docker >/dev/null 2>&1 && alias d='docker'
command -v rails >/dev/null 2>&1 && alias r='rails'
command -v tmux >/dev/null 2>&1 && {
  alias t='tmux attach || tmux new -s Work'
  # Tmux dev layout + AI agent panes (see functions-omarchy.zsh)
  alias ic='tdl c'
  alias ix='tdl cx'
  alias icx='tdl c cx'
}
if command -v mise >/dev/null 2>&1; then
  alias mup='MISE_MINIMUM_RELEASE_AGE=0 mise up'
fi
n() {
  if (( $# == 0 )); then
    command nvim .
  else
    command nvim "$@"
  fi
}

# --- Git ---
alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'