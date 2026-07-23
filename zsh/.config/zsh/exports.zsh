# ==========================
# History Configuration
# ==========================

HISTFILE="$HOME/.zsh_history"
# Memory history size
HISTSIZE=10000
# Saved history size
SAVEHIST=10000

# Append instead of overwrite
setopt APPEND_HISTORY

# Share history between terminals
setopt SHARE_HISTORY

# Remove duplicates
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS

# Remove useless spaces
setopt HIST_REDUCE_BLANKS

# Save timestamps
setopt EXTENDED_HISTORY

WORDCHARS=${WORDCHARS//[\/]}