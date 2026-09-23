# ==========================
# Zsh Configuration
# ==========================

# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# Source custom configurations in dependency order:
#   exports -> aliases -> functions -> completion -> plugins -> keybindings -> options
# (plugins are loaded before keybindings so their widgets/keys can be bound)

# Environment
source ~/.config/zsh/exports.zsh

# Aliases
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/aliases-omarchy.zsh

# Functions
source ~/.config/zsh/functions.zsh
source ~/.config/zsh/functions-omarchy.zsh

# Completion
source ~/.config/zsh/completion.zsh

# Plugins (each integration is guarded against a missing tool)
source ~/.config/zsh/plugins.zsh

# Keybindings
source ~/.config/zsh/keybindings.zsh

# Options
source ~/.config/zsh/options.zsh

# Source secrets if the file exists.
[[ -f ~/.secrets ]] && source ~/.secrets