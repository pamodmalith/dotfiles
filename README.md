# dotfiles

Personal configuration files for **Pamod Malith** — an Arch Linux / Hyprland desktop environment.

## System Overview

| Component     | Choice                                              |
| ------------- | --------------------------------------------------- |
| OS            | [Arch Linux](https://archlinux.org/)                |
| Compositor    | [Hyprland](hypr/.config/hypr/)                      |
| Shell         | Zsh (framework-free)                                |
| Prompt        | [Starship](https://starship.rs/)                    |
| Terminal      | Kitty                                               |
| Editor        | Neovim (LazyVim) + VS Code                          |
| Launcher      | Rofi (12 themes)                                    |
| Bar           | [Wayle](wayle/.config/wayle/)                       |
| Notifications | Wayle (built-in center)                             |
| Lock Screen   | hyprlock + hypridle                                 |
| Power Menu    | wlogout                                             |
| PDF Viewer    | Zathura                                             |
| File Manager  | Thunar + Yazi                                       |
| Clipboard     | cliphist + wl-clip-persist                          |
| Video         | MPV                                                 |

## Directory Structure

```
dotfiles/
├── hypr/         — Hyprland compositor (Lua modules)
├── wayle/        — Status panel + notification center
├── wlogout/      — Power menu
├── rofi/         — App launcher & menus
├── kitty/        — Terminal emulator
├── nvim/         — Neovim (LazyVim)
├── zsh/          — Shell config (modular)
├── starship/     — Prompt
├── mpv/          — Video player
├── zathura/      — PDF viewer
├── git/          — Global git config
├── rclone/       — Backup automation (systemd timer)
├── opencode/     — AI coding assistant
├── scripts/      — System utilities (update, cleanup, extract)
├── docs/         — Architecture notes
├── .vscode/      — Editor settings
└── archive/      — Retired configs (waybar, swaync)
```

Every config follows the `~/.config/<app>/` XDG convention. Apply with `stow` or manual symlinks.

## Hyprland

Modular Lua configuration split into single-purpose files:

| Module            | Purpose                                                       |
| ----------------- | ------------------------------------------------------------- |
| `monitors.lua`    | eDP-1 laptop + HDMI-A-1 external display                      |
| `autostart.lua`   | Launches wayle, awww-daemon, cliphist, hypridle, polkit agent |
| `binds.lua`       | Keybindings (`Super` + key combos)                            |
| `decorations.lua` | Gaps, borders, shadows, blur, animations                      |
| `env.lua`         | Wayland environment variables                                 |
| `input.lua`       | Keyboard layout (US), touchpad, gestures                      |
| `layout.lua`      | Dwindle, Master, Scrolling layouts                            |
| `misc.lua`        | Misc settings                                                 |
| `programs.lua`    | Central app path definitions                                  |
| `rules.lua`       | Workspace assignments                                         |
| `windowrules.lua` | Floating rules for dialogs, PIP, media apps                   |

### Screenshots

Four capture methods via `hypr/.config/hypr/scripts/`:

- `screenshot-full.sh` — Full desktop
- `screenshot-monitor.sh` — Current monitor
- `screenshot-region.sh` — Interactive region (`slurp`)
- `screenshot-window.sh` — Active window

All save to `~/Pictures/Screenshots/` and copy to clipboard.

## Wayle

Wayle replaced both Waybar and SwayNC (now under `archive/`) as the single status bar and notification solution. TOML-based config with runtime theme switching:

- Top bar with button groups: dashboard, workspaces, notifications, clock, systray, battery, bluetooth, network, mic, volume
- Integrated notification center with popups, Do Not Disturb, and action buttons
- Dropdown panels for audio, network, bluetooth, calendar, weather, media, and a system dashboard (lock/logout/reboot/poweroff)
- Built-in OSD and wallpaper engine
- Theme provider supporting manual palettes plus Matugen, Wallust, and Pywal generation

Custom palette in `config.toml` (`[styling.palette]`); per-theme palettes validated against `themes/schema.json`.

## Rofi

12 themed (thanks to [newmanls](https://github.com/newmanls/rofi-themes-collection)) launcher variants under `rofi/.config/rofi/themes/` plus:

| Script               | Purpose                                  |
| -------------------- | ---------------------------------------- |
| `launcher.sh`        | Application launcher (`rofi -show drun`) |
| `cliphist-rofi-img`  | Clipboard history with image previews    |
| `screenshot-menu.sh` | Screenshot type selection menu           |

The active theme is set in `main.rasi`.

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
| `plugins.zsh`     | Starship, zoxide, fzf, fnm, autosuggestions, syntax highlighting         |

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

Custom dark palette (`#141420` base) inspired by Catppuccin Mocha:

| Token      | Hex       |
| ---------- | --------- |
| Base       | `#141420` |
| Surface    | `#1c1c2c` |
| Elevated   | `#262638` |
| Foreground | `#d4d6e8` |
| Muted      | `#8a8ca4` |
| Primary    | `#e0947a` |
| Red        | `#e46870` |
| Yellow     | `#e0b870` |
| Green      | `#68c898` |
| Blue       | `#78a0e0` |

## License

Private config — feel free to borrow ideas.
