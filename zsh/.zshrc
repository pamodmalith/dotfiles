# ==========================
# Zsh Configuration
# ==========================

# Source custom configurations

# Environment
source ~/.config/zsh/exports.zsh

# Aliases
source ~/.config/zsh/aliases.zsh

# Functions
source ~/.config/zsh/functions.zsh

# Completion
source ~/.config/zsh/completion.zsh

# Plugins
source ~/.config/zsh/plugins.zsh

# Keybindings
source ~/.config/zsh/keybindings.zsh

# Source secrets if the file exists. 
[[ -f ~/.secrets ]] && source ~/.secrets
