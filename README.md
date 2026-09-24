# dotfiles

Personal configuration files for **Pamod Malith** — an Arch Linux / Hyprland desktop environment.

## System Overview

| Component     | Choice                                              |
| ------------- | --------------------------------------------------- |
| OS            | [Arch Linux](https://archlinux.org/)                |
| Compositor    | [Hyprland](hypr/.config/hypr/)                      |
| Session       | [UWSM](uwsm/.config/uwsm/env)                       |
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
├── uwsm/         — UWSM session environment variables
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
├── setup/        — One-time machine setup (install + stow)
├── scripts/      — System utilities (update, cleanup, extract)
├── docs/         — Architecture notes
├── xfce4/        — XFCE helpers (kitty terminal)
├── .vscode/      — Editor settings
└── archive/      — Retired configs (waybar, swaync, hypr screenshots)
```

Every config follows the `~/.config/<app>/` XDG convention. Apply with GNU `stow` or manual symlinks — or run `bash ~/dotfiles/setup/setup_zsh.sh` for a one-shot setup of the zsh stack (installs tools, stows the `zsh` package, sets zsh as login shell).

## Hyprland

Modular Lua configuration split into single-purpose files:

| Module              | Purpose                                                       |
| ------------------- | ------------------------------------------------------------- |
| `variables.lua`     | Central app paths, monitor names, workspace count             |
| `monitors.lua`      | eDP-1 laptop + HDMI-A-1 external display                      |
| `autostart.lua`     | Launches wayle, awww-daemon, cliphist, hypridle, polkit agent |
| `binds.lua`         | Keybindings (`Super` + key combos)                            |
| `decorations.lua`   | Gaps, borders, shadows, blur                                  |
| `animations.lua`    | Curves and window animations                                  |
| `colors.lua`        | Cachy color definitions for decorations                       |
| `env.lua`           | Stub — env vars live in UWSM (`~/.config/uwsm/env`)           |
| `input.lua`         | Keyboard layout (US), touchpad, gestures                      |
| `layout.lua`        | Dwindle, Master, Scrolling layouts                            |
| `misc.lua`          | Misc settings                                                 |
| `windowrules.lua`   | Floating rules for dialogs, PIP, media apps                   |
| `workspaces.lua`    | Workspace rules                                               |

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

| File                    | Purpose                                                                  |
| ----------------------- | ------------------------------------------------------------------------ |
| `aliases.zsh`           | `eza` (ls), `bat` (cat), `paru`, `pomo`                                  |
| `aliases-omarchy.zsh`   | Omarchy imports: eza extras, fzf finder (`ff`), git, AI/dev aliases      |
| `completion.zsh`        | `compinit` with caching                                                  |
| `exports.zsh`           | PATH, `EDITOR`, `SDL_VIDEODRIVER`, bat-powered man pages                 |
| `functions.zsh`         | `mkcd`, auto-`ls` on dir change                                          |
| `functions-omarchy.zsh` | Omarchy ports: git worktrees, SSH tunnels, rsync watchers, tmux layouts  |
| `keybindings.zsh`       | Emacs mode, word movement, history search                                |
| `options.zsh`           | History (10k lines, share, dedup)                                        |
| `plugins.zsh`           | Starship, zoxide, fzf, mise, autosuggestions, syntax highlighting        |

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

## License

Private config — feel free to borrow ideas.
