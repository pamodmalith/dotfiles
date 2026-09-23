# ==========================
# Zsh Plugins
# ==========================
#
# Every integration is guarded: if the tool/plugin isn't installed the line is
# skipped instead of erroring. See README "Required tools" for install commands.

# --- Starship prompt ---
#   Required tool: starship  ->  eval "$(starship init zsh)"
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# --- zoxide (smart cd) ---
#   Required tool: zoxide  ->  eval "$(zoxide init zsh)"
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# --- fzf (fuzzy finder + Ctrl-R / Ctrl-T) ---
#   Required tool: fzf  ->  source <(fzf --zsh)
#   2>/dev/null: fzf's key-bindings emits "can't change option: zle" in
#   non-TTY interactive shells (IDE panels, piped stdin); harmless, silenced.
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh) 2>/dev/null
fi

# --- mise (dev runtime versions: node, python, ...) ---
#   Required tool: mise  ->  eval "$(mise activate zsh)"
#   Replaces fnm: manages node + other toolchains and switches versions
#   automatically when you cd into a directory with .mise.toml/.tool-versions.
#   (Registers a chpwd hook; coexists with the auto-`ls` chpwd hook.)
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# --- zsh-autosuggestions (grey ghost-text suggestions) ---
#   Required package: zsh-autosuggestions
#   -> source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# --- zsh-syntax-highlighting (colors commands as you type) ---
#   Required package: zsh-syntax-highlighting (load after autosuggestions)
#   -> source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# --- zsh-history-substring-search (arrows match what you typed) ---
#   Required package: zsh-history-substring-search
#   -> source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
if [[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
fi