export PATH="$HOME/.local/bin:$PATH"
export SDL_VIDEODRIVER="wayland,x11"

# Editor used by CLI tools (nvim via the `n` function / $EDITOR)
export EDITOR="${EDITOR:-nvim}"

# Pretty man pages with bat (when bat is installed)
if command -v bat >/dev/null 2>&1; then
  export BAT_THEME=ansi
  export MANROFFOPT="-c"
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi