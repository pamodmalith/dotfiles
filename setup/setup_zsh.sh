#!/usr/bin/env bash
# =============================================================================
# One-time setup for the zsh dotfiles (managed with GNU stow).
#
#  * Installs every tool the config integrates with (eval/source lines)
#  * Stows the `zsh` package from the dotfiles repo into $HOME
#    (replaces any previous plain-file/copy versions with symlinks)
#  * Sets zsh as your default login shell
#
# The dotfiles repo is assumed to live at ~/dotfiles (adjust DOTFILES below).
# Run from anywhere:
#   bash ~/dotfiles/setup/setup.sh
# =============================================================================
set -euo pipefail

# Stow root = parent of this script's directory (the dotfiles repo)
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGE="zsh"

echo "==> [1/4] Installing shell tools via pacman..."
sudo pacman -S --needed --noconfirm \
  zsh zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search \
  starship zoxide fzf eza bat fd gum inotify-tools stow \
  parted exfatprogs \
  mise

echo "==> [2/4] Stowing dotfiles (symlinking $PACKAGE into \$HOME)..."
command -v stow >/dev/null 2>&1 || {
  echo "stow not found - install it first: sudo pacman -S stow"
  exit 1
}

# Remove plain copies (non-symlinks) so stow can link cleanly.
# Anything found is backed up, never deleted.
for target in "$HOME/.zshrc" "$HOME/.config/zsh"; do
  if [ -L "$target" ]; then
    echo "  $target already a symlink - keeping"
  elif [ -e "$target" ]; then
    backup="${target}.bak-$(date +%s)"
    echo "  backing up $target -> $backup"
    mv "$target" "$backup"
  fi
done

mkdir -p "$HOME/.config" "$HOME/.cache/zsh"
( cd "$DOTFILES" && stow -v "$PACKAGE" )
echo "  ~/.zshrc      -> $DOTFILES/zsh/.zshrc"
echo "  ~/.config/zsh -> $DOTFILES/zsh/.config/zsh"

echo "==> [3/4] Verifying the config parses..."
zsh -n "$HOME/.zshrc"

echo "==> [4/4] Setting zsh as default shell (asks for your password)..."
chsh -s /usr/bin/zsh

echo
echo "Done. Restart your terminal or run:  exec zsh"
echo "Reminder: node + other dev toolchains are managed by mise."
echo "Check what's installed:  mise ls   |   install one:  mise use -g node@lts"
echo "Optional extras: neovim (sudo pacman -S neovim), tmux (sudo pacman -S tmux),"
echo "rust toolchain (curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh)"