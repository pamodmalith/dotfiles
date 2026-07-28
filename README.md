# dotfiles

Personal configuration files for **Pamod Malith** — an Arch Linux / Hyprland desktop environment.

## System Overview

| Component     | Choice                         |
| ------------- | ------------------------------ |
| OS            | Arch Linux                     |
| Compositor    | [Hyprland](hypr/.config/hypr/) |
| Shell         | Zsh (framework-free)           |
| Prompt        | Starship                       |
| Terminal      | Kitty                          |
| Editor        | Neovim (LazyVim) + VS Code     |
| Launcher      | Rofi (12 themes)               |
| Bar           | Waybar                         |
| Notifications | SwayNC                         |
| Lock Screen   | hyprlock + hypridle            |
| File Manager  | Thunar + Yazi                  |
| Clipboard     | cliphist + wl-clip-persist     |
| Video         | MPV                            |

## Directory Structure

```
dotfiles/
├── hypr/         — Hyprland compositor (Lua modules)
├── waybar/       — Status bar
├── wlogout/      — Power menu
├── swaync/       — Notification center
├── rofi/         — App launcher & menus
├── kitty/        — Terminal emulator
├── nvim/         — Neovim (LazyVim)
├── zsh/          — Shell config (modular)
├── starship/     — Prompt
├── mpv/          — Video player
├── git/          — Global git config
├── rclone/       — Backup automation (systemd timer)
├── opencode/     — AI coding assistant
├── scripts/      — System utilities (update, cleanup, extract)
├── docs/         — Architecture notes
└── .vscode/      — Editor settings
```

Every config follows the `~/.config/<app>/` XDG convention. Apply with `stow` or manual symlinks.

## Hyprland

Modular Lua configuration split into single-purpose files:

| Module            | Purpose                                                      |
| ----------------- | ------------------------------------------------------------ |
| `monitors.lua`    | eDP-1 laptop + HDMI-A-1 external display                     |
| `autostart.lua`   | Launches waybar, swaync, cliphist, hypridle, hyprpolkitagent |
| `binds.lua`       | Keybindings (`Super` + key combos)                           |
| `decorations.lua` | Gaps, borders, shadows, blur, animations                     |
| `env.lua`         | Wayland environment variables                                |
| `input.lua`       | Keyboard layout (US), touchpad, gestures                     |
| `layout.lua`      | Dwindle, Master, Scrolling layouts                           |
| `misc.lua`        | Misc settings                                                |
| `programs.lua`    | Central app path definitions                                 |
| `rules.lua`       | Workspace assignments                                        |
| `windowrules.lua` | Floating rules for dialogs, PIP, media apps                  |

### Screenshots

Four capture methods via `hypr/.config/hypr/scripts/`:

- `screenshot-full.sh` — Full desktop
- `screenshot-monitor.sh` — Current monitor
- `screenshot-region.sh` — Interactive region (`slurp`)
- `screenshot-window.sh` — Active window

All save to `~/Pictures/Screenshots/` and copy to clipboard.

## Rofi

12 themed (thanks to [newmanls](https://github.com/newmanls/rofi-themes-collection)) launcher variants under `rofi/.config/rofi/themes/` plus:

| Script               | Purpose                                  |
| -------------------- | ---------------------------------------- |
| `launcher.sh`        | Application launcher (`rofi -show drun`) |
| `cliphist-rofi-img`  | Clipboard history with image previews    |
| `screenshot-menu.sh` | Screenshot type selection menu           |

The active theme is set in `main.rasi`.

## Waybar

Glass-morphism dark bar with pill-shaped modules. Power button launches wlogout.

## SwayNC

Notification center with Catppuccin Mocha theming. Features:

- MPRIS media controls
- Do Not Disturb toggle
- Backlight & volume sliders
- Quick action buttons grid

## Zsh

Framework-free modular config in `zsh/.config/zsh/`:

| File              | Purpose                                                                  |
| ----------------- | ------------------------------------------------------------------------ |
| `aliases.zsh`     | `eza` (ls), `bat` (cat), `paru`, `pomo`                                  |
| `completion.zsh`  | `compinit` with caching                                                  |
| `exports.zsh`     | PATH additions                                                           |
| `functions.zsh`   | `mkcd`, auto-`ls` on dir change                                          |
| `keybindings.zsh` | Emacs mode, word movement, history search                                |
| `options.zsh`     | History (10k lines, share, dedup)                                        |
| `plugins.zsh`     | Starship, zoxide, fzf, fnm, SDKMAN, autosuggestions, syntax highlighting |

## Scripts

System utility scripts in `scripts/.local/bin/`:

| Script    | Purpose                                                      |
| --------- | ------------------------------------------------------------ |
| `update`  | `pacman -Syu` + `paru -Sua` + orphan check                   |
| `cleanup` | Cache clean, journal vacuum, orphan removal                  |
| `extract` | Universal archive extractor (tar, zip, 7z, rar, gz, bz2, xz) |

## Rclone Backup

Automated daily backups of `~/uni`, `~/java-uni`, `~/vault` to Google Drive via systemd user timer.
See [rclone/README.md](rclone/README.md) for setup instructions.

## CLI Tool Replacements

| Tool     | Replaces       |
| -------- | -------------- |
| `eza`    | `ls`           |
| `bat`    | `cat`          |
| `fd`     | `find`         |
| `rg`     | `grep`         |
| `jq`     | JSON processor |
| `fzf`    | Fuzzy finder   |
| `zoxide` | `cd`           |

## Color Palette

Catppuccin Mocha inspired:

| Token  | Hex       |
| ------ | --------- |
| Base   | `#1e1e2e` |
| Text   | `#cdd6f4` |
| Blue   | `#89b4fa` |
| Mauve  | `#cba6f7` |
| Red    | `#f38ba8` |
| Green  | `#a6e3a1` |
| Yellow | `#f9e2af` |

## License

Private config — feel free to borrow ideas.
