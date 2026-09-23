# Zsh Configuration

A minimal, modular, framework-free Zsh configuration for my Arch/CachyOS + Hyprland setup.

## Philosophy

This configuration is intentionally built **without a framework** such as Oh My Zsh or Zim.

Instead of relying on a large framework, every feature is configured manually. This keeps the shell lightweight, easier to understand, and easier to maintain.

The goal is to know what every file does.

In 2026 this config was extended with aliases and functions imported from **[Omarchy](https://github.com/basecamp/omarchy)'s default bash** (DHH's omarchy distribution). Everything imported was validated and adapted to zsh — see `aliases-omarchy.zsh` and `functions-omarchy.zsh`.

---

## Structure

```text
zsh
├── .zshrc
└── .config
    └── zsh
        ├── aliases.zsh         # personal aliases
        ├── aliases-omarchy.zsh # aliases imported from Omarchy bash (validated)
        ├── completion.zsh
        ├── exports.zsh
        ├── functions.zsh       # personal functions
        ├── functions-omarchy.zsh # functions imported from Omarchy bash (validated)
        ├── keybindings.zsh
        ├── options.zsh
        └── plugins.zsh
```

### `.zshrc`

Small bootstrap file.

Loads the modular configuration files in dependency order:

```text
exports -> aliases (+ omarchy) -> functions (+ omarchy) -> completion
        -> plugins -> keybindings -> options -> secrets
```

Plugins load *before* keybindings so the plugin widgets (history substring search)
exist when they get bound.

### `options.zsh`

Shell behavior.

* shell options (`setopt`)
* history behavior (shared, deduplicated, timestamped)
* editor mode
* word movement settings

### `exports.zsh`

Environment variables.

* `PATH`
* `EDITOR` (nvim)
* `SDL_VIDEODRIVER`
* bat-powered man pages (`MANPAGER`) when bat is installed

### `aliases.zsh`

Personal aliases (eza `ls`/`ll`/`la`, bat `cat`, paru `s`/`i`, ...).

### `aliases-omarchy.zsh`

Aliases imported from Omarchy's bash config and validated for zsh:

* eza extras (`lsa`, `lt`, `lta`)
* fzf file finder (`ff`, `eff`, `sff`) with kitty image preview
* zoxide-powered `cd` (`zd` — only active when zoxide is installed)
* `open`, `..`/`...`/`....`
* AI/dev aliases (`c`=opencode, `cx`=claude, `cy`=codex, `d`, `r`, `t`, `ic`/`ix`/`icx`)
* git aliases (`g`, `gcm`, `gcam`, `gcad`), `mup` (mise update), `n` (nvim)

Every alias is guarded: it only exists if its tool is installed.

### `functions.zsh`

Personal shell functions (`mkcd`, auto-`ls` on directory change).

### `functions-omarchy.zsh`

Functions imported from Omarchy's bash config (`omarchy/default/bash/fns/*`),
ported to zsh and fixed while doing so:

* `compress` / `decompress`
* git worktrees — `ga`, `gd` (gum confirm, plain-read fallback)
* SSH port forwarding — `fip`, `dip`, `lip`
* rsync-on-change watchers — `rsw`, `lsw`, `dsw`
* `ssh` reconnection wrapper (disarms terminal modes, auto-reconnects)
* `format-drive` (exFAT; requires parted + exfatprogs)
* tmux dev layouts — `tdl`, `tds`, `tdlm`, `tsl` (only when tmux is installed)

### `completion.zsh`

Zsh completion configuration.

Includes a cached `compinit`, menu selection, grouped/described matches,
colors, and case-insensitive matching.

### `plugins.zsh`

Loads external tools and plugins. **Every line is guarded** — a missing tool
is skipped instead of erroring, so the shell works even before the tools are
installed.

| What | Init line | Required tool |
|------|-----------|---------------|
| Starship prompt | `eval "$(starship init zsh)"` | `starship` |
| zoxide directory jumping | `eval "$(zoxide init zsh)"` | `zoxide` |
| fzf integration | `source <(fzf --zsh) 2>/dev/null` | `fzf` |
| mise (runtime versions: node, ...) | `eval "$(mise activate zsh)"` | `mise` |
| Autosuggestions | `source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh` | `zsh-autosuggestions` |
| Syntax highlighting | `source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh` | `zsh-syntax-highlighting` |
| History substring search | `source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh` | `zsh-history-substring-search` |

### `keybindings.zsh`

Keyboard shortcuts and widget bindings.

* Ctrl + Left / Right word movement
* Up/Down + Ctrl+P/N history substring search (only when the plugin is loaded)
* Ctrl+Backspace / Ctrl+Delete word deletion
* Home / End
* Custom key mappings

---

## Features

* Framework-free configuration
* Modular file layout
* Fast shell startup (only guards and cheap evals — no heavy frameworks)
* Starship prompt
* zoxide directory jumping
* fzf integration (Ctrl-R history, Ctrl-T files, `ff` file finder)
* mise (node + other runtime version management; replaces fnm)
* Autosuggestions
* Syntax highlighting
* History substring search
* Custom keybindings
* Shared shell history
* Duplicate-free history
* Omarchy imported aliases + functions (validated)

---

## Setup on a new machine

```bash
# 1. Clone the dotfiles repo:
git clone https://github.com/pamodmalith/dotfiles ~/dotfiles

# 2. Install all tools, stow the symlinks, set zsh as default shell:
bash ~/dotfiles/setup/setup_zsh.sh
```

`setup_zsh.sh` (kept at `~/dotfiles/setup/`, outside the `zsh` package so it's never
stowed) installs the packages below with `pacman`, **stows** the `zsh`
package from `~/dotfiles` into `$HOME` (`stow zsh` — creating
`~/.zshrc` and `~/.config/zsh` symlinks, after backing up any previous plain
copies), and runs `chsh -s /usr/bin/zsh`.

> Stow note: this repo is a stow root. The `zsh` directory is one package.
> If you had an older non-stowed copy at `~/.zshrc` / `~/.config/zsh`,
> `setup_zsh.sh` moves those to `*.bak-<timestamp>` before linking.

### Required tools & shell integrations (`eval` / `source`)

These are the tools the config **integrates with** and the init lines that make
each one work. The integrations live in `plugins.zsh` (and are all guarded), so
installing the tool is all it takes to turn the feature on.

| Tool / package | Install (Arch/CachyOS) | Init line used by this config | Turns on |
|---|---|---|---|
| `starship` | `sudo pacman -S starship` | `eval "$(starship init zsh)"` | Prompt |
| `zoxide` | `sudo pacman -S zoxide` | `eval "$(zoxide init zsh)"` | Smart `cd` + `zd` alias |
| `fzf` | `sudo pacman -S fzf` | `source <(fzf --zsh) 2>/dev/null` | Ctrl-R / Ctrl-T / `ff` |
| `mise` | `sudo pacman -S mise` *(already installed)* | `eval "$(mise activate zsh)"` | Node & toolchain versions, auto-switch on `cd` |
| `zsh-autosuggestions` | `sudo pacman -S zsh-autosuggestions` | `source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh` | Ghost-text suggestions |
| `zsh-syntax-highlighting` | `sudo pacman -S zsh-syntax-highlighting` | `source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh` | Syntax highlighting |
| `zsh-history-substring-search` | `sudo pacman -S zsh-history-substring-search` | `source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh` | Arrow-key history search |

Tools the **handy functions/aliases** use (not `eval`/`source`, but needed for
full feature parity):

| Tool / package | Install | Used by |
|---|---|---|
| `eza` | `sudo pacman -S eza` | `ls`, `ll`, `la`, `lsa`, `lt`, `lta` |
| `bat` | `sudo pacman -S bat` | `cat`, `ff` preview, man pages |
| `gum` | `sudo pacman -S gum` | `gd` confirmation dialog |
| `inotify-tools` | `sudo pacman -S inotify-tools` | `rsw`/`lsw`/`dsw` watchers |
| `parted` + `exfatprogs` | `sudo pacman -S parted exfatprogs` | `format-drive` |
| `tmux` | `sudo pacman -S tmux` | `t`, `tdl`, `tds`, `tdlm`, `tsl` |
| `neovim` | `sudo pacman -S neovim` | `n`, `eff`, `EDITOR` |
| `opencode` | your usual install | `c` alias |

## Design Goals

* Minimal
* Readable
* Modular
* Easy to debug
* Easy to extend
* XDG-friendly
* Suitable for version control

## Future Improvements

* Full XDG (`ZDOTDIR`) migration
* Additional custom shell functions
* Better completion styles
* Improved Git workflow helpers
* Project-specific aliases
* Performance benchmarking

---

Part of my personal Arch/CachyOS + Hyprland dotfiles.