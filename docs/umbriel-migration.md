# Umbriel Migration Report & Reference

This document tracks all design decisions, configuration mappings, active settings, and unsupported/unported features resulting from migrating and running Umbriel side by side with Hyprland in this dotfiles repository.

---

## 1. Architectural Decisions & Current Configuration

### 1.1 Side-by-Side Coexistence
- All Hyprland configurations ([`hypr/`](file:///home/pamod/dotfiles/hypr/)), UWSM configs ([`uwsm/`](file:///home/pamod/dotfiles/uwsm/)), Wayle, Rofi, and other desktop configurations remain intact and functional.
- Umbriel configuration is managed as an independent GNU Stow package located at [`umbriel/.config/umbriel/`](file:///home/pamod/dotfiles/umbriel/.config/umbriel/).

### 1.2 Modular Configuration Architecture
The root configuration file [config.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/config.toml) uses Umbriel's native `[include]` directive to include dedicated module files from [`umbriel/.config/umbriel/modules/`](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/):

| Module File | Role & Current Configuration Scope |
| :--- | :--- |
| [general.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/general.toml) | Session autostart (`noctalia`, `xhost +SI:localuser:root`), XWayland options, modal dialog attachment, environment variables, lid switch events. |
| [outputs.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/outputs.toml) | Display resolutions, positions, refresh rates, scales, VRR settings, and dynamic workspace binding. |
| [layout.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/layout.toml) | Horizontal scrolling layout settings, gaps, extent presets, default window width fractions, and tab group positioning. |
| [appearance.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/appearance.toml) | Window borders, corner rounding, CSD preferences, fullscreen opacity, dual-pass blur, and CachyOS border color palette. |
| [input.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/input.toml) | Mouse & touchpad flat acceleration, natural scroll, tap-to-click, keyboard compose key (`ralt`), NumLock persistence, cursor theme (`Bibata-Modern-Ice`), and hover-focus behavior. |
| [keybinds.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/keybinds.toml) | Complete replacement keybind table matching Hyprland muscle memory while adding Umbriel scrolling and Noctalia shell controls. |
| [workspaces.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/workspaces.toml) | Named scratchpads (`s` and `magic`). Output workspace pinning is intentionally set to dynamic in `outputs.toml`. |
| [window-rules.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/window-rules.toml) | Application placement, output routing (`HDMI-A-1` for gaming, `eDP-1` for Wine/chat), floating dialogs, Thunar regex matching, fixed-size centered floats, and Zoom Workplace glitch fixes. |
| [layer-rules.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/layer-rules.toml) | Noctalia shell layer rules (wallpaper blur caching for panels/widgets, live unoptimized background blur for popups/dock/notifications). |
| [hot-corners.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/hot-corners.toml) | Top-left screen hot corner opening the workspace overview with a 500ms delay. |
| [effects.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/effects.toml) | Visual shader effects reference templates (pulse borders, cursor trails, audio-reactive borders). |

---

### 1.3 Monitors & Output Routing
Configured in [outputs.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/outputs.toml):
- **Laptop Panel (`eDP-1`)**:
  - Mode: `1920x1080@60`
  - Position: `[0, 0]`
  - Scale: `1.0`
  - Transform: `"normal"`
  - Workspaces: `"dynamic"`
- **External Monitor (`HDMI-A-1`)**:
  - Mode: `1920x1080@60`
  - Position: `[1920, 0]`
  - Scale: `1.0`
  - VRR: `"fullscreen"`
  - Workspaces: `"dynamic"`
  - State: `enabled = true`

> [!NOTE]
> **Dynamic Workspaces vs. Static Workspace Pinning**:
> In Hyprland, `gaming` was explicitly pinned to the external monitor via `hl.workspace_rule({ workspace = "name:gaming", monitor = vars.monitors.two })`.
> In Umbriel, both displays use `workspaces = "dynamic"`. Instead of locking a specific workspace number/name to an output, gaming workloads are directed via window rules:
> - `match.content_type = 'game'` $\rightarrow$ `default_output = 'HDMI-A-1'`
> - `match.xdg_tag = '^.*game.*$'` $\rightarrow$ `default_output = 'HDMI-A-1'`, `default_fullscreen = true`
> - `match.app_id = '^(steam_app.*|gamescope)$'` $\rightarrow$ `default_output = 'HDMI-A-1'`, `confine_pointer = true`

---

### 1.4 Session, Environment Variables & Autostart
Configured in [general.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/general.toml):
- **General Compositor Settings**:
  - `show_cheatsheet = false`: Umbriel's built-in keybind cheatsheet does not launch on startup; it is toggled on demand via `Mod+K`.
  - `attach_modal_dialogs = true`: Child dialogs attach to and follow their parent window.
  - `xwayland = true`: XWayland enabled with `xwayland_native_resolution = true` (zero scaling for sharp X11 apps/games) and `xwayland_xsettings = true` (announces cursor theme and scale to X11 clients).
- **Autostart**:
  - `autostart = ["noctalia", "xhost +SI:localuser:root"]`:
    - Launches the Noctalia desktop shell (bar, dock, notifications, OSD).
    - Runs `xhost +SI:localuser:root` so GUI administrative tools (e.g., GParted, Timeshift) running under `pkexec`/`sudo` can display on the XWayland server without permission denial.
- **Environment Table (`[environment]`)**:
  Ported directly from [`uwsm/.config/uwsm/env`](file:///home/pamod/dotfiles/uwsm/.config/uwsm/env):
  - `BROWSER = "firefox"`
  - `QT_QPA_PLATFORM = "wayland;xcb"`
  - `QT_QPA_PLATFORMTHEME = "qt6ct"`
  - `ELECTRON_OZONE_PLATFORM_HINT = "auto"`
  - `GTK_IM_MODULE = "xim"` & `QT_IM_MODULE = "xim"` (enforces XCompose sequence processing across GTK and Qt frameworks)
  - `XCOMPOSEFILE = "/home/pamod/.XCompose"` (absolute path to custom compose file)
  - `TERM=xterm-kitty` dropped (Kitty manages its own terminfo internally).

---

### 1.5 Input, Pointer & Focus
Configured in [input.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/input.toml):
- **Acceleration**: `accel_profile = "flat"` on both mouse and touchpad for consistent 1:1 sensor input.
- **Touchpad**: `natural_scroll = true`, `tap = true`.
- **Keyboard**: `options = "compose:ralt"` (Right Alt serves as Multi_key), `numlock_toggle = true`.
- **Cursor Theme**: `theme = "Bibata-Modern-Ice"`, `size = 24`.
- **Focus Behavior**:
  - `middle_click_paste = false` (prevents accidental clipboard dumps when clicking the scroll wheel).
  - `[input.focus] hover_raises = false`: Hovering over a window focuses it, but does not aggressively raise it to the top of the floating stack until clicked or activated by keybind.
- **Lid Events**:
  - `lid_close = "umbriel msg output-disable eDP-1"`
  - `lid_open = "umbriel msg output-enable eDP-1"`

---

### 1.6 Layout & Navigation
Configured in [layout.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/layout.toml):
- **Mode**: Horizontal scrolling layout (`mode = "scrolling"`).
- **Gaps**: Unified `gap = 8` (replaces Hyprland's `gaps_in = 3` and `gaps_out = 8`).
- **Extent Presets**: `extent_presets = [0.333, 0.5, 0.667]`
  - Cycled forward via `Mod+R` (`window-cycle-primary-extent`).
  - Cycled backward via `Mod+Shift+R` (`window-cycle-primary-extent-back`).
  - Default initial window fraction: `default_extent_fraction = 0.5` (new windows open taking half the display width).
- **Tabbed Windows**: `new_tab_position = "after_active"` within tabbed columns.
- **Workspace Overview**:
  - Tapping standalone `Mod` (Super) triggers `overview-toggle`.
  - Top-left screen hot corner triggers `overview-open` after 500ms delay.
  - Native 4-finger touchpad swipe toggles overview.

---

### 1.7 Appearance & Styling
Configured in [appearance.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/appearance.toml):
- `prefer_no_csd = true`: Requests server-side decorations from client toolkits.
- `border_width = 2`: Matches Hyprland's 2px border.
- `corner_radius = 10`: Matches Hyprland's 10px rounded corners.
- `opaque_fullscreen = true`: Disables compositor transparency when an application is fullscreen.
- **Dual-Pass Blur**:
  - `enabled = true`
  - `optimized = true`
  - `passes = 4`
  - `radius = 5` (matches Hyprland's `size = 5`, `passes = 4`)
- **Border Palette**:
  - `colors.border.focused = "#82dcccff"` (CachyOS active cyan accent)
  - `colors.border.unfocused = "#798bb2ff"` (Inactive slate grey)

---

## 2. Complete Keybind Mapping Reference

Defining `[keybinds]` in [keybinds.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/keybinds.toml) replaces Umbriel's built-in key table. All bindings are mapped directly to Hyprland shortcuts, Noctalia shell IPC actions, or Umbriel actions:

### 2.1 Applications & Launchers
| Key Chord | Action / Command | Rationale |
| :--- | :--- | :--- |
| `Mod+Return` | `spawn:kitty` | Terminal launcher (`repeat = false`) |
| `Mod+E` | `spawn:thunar` | File manager launcher (`repeat = false`) |
| `Mod+Shift+T` | `spawn:gnome-text-editor --new-window` | Text editor launcher (`repeat = false`) |
| `Mod+Shift+C` | `spawn:gnome-calculator` | Calculator launcher (`repeat = false`) |
| `XF86Calculator`| `spawn:gnome-calculator` | Hardware calculator key launcher |
| `Mod+W` | `spawn:firefox` | Web browser launcher (`repeat = false`) |
| `Ctrl+Shift+Escape` | `spawn:kitty -e btop` | Task manager launcher (`repeat = false`) |

### 2.2 Noctalia Shell & Session Controls
| Key Chord | Action / Command | Description |
| :--- | :--- | :--- |
| `Mod` (tap) | `overview-toggle` | Workspace overview toggle on single tap |
| `Mod+K` | `spawn:umbriel msg cheatsheet-toggle`| Umbriel visual keybind cheatsheet |
| `Mod+Z` | `spawn:noctalia msg settings-toggle` | Noctalia settings panel |
| `Mod+X` | `spawn:noctalia msg panel-toggle control-center` | Noctalia control center toggle |
| `Mod+Space` | `spawn:noctalia msg panel-toggle launcher` | App launcher toggle |
| `Mod+Period` | `spawn:noctalia msg panel-toggle launcher /emo` | Emoji picker overlay |
| `Mod+L` | `spawn:noctalia msg session lock` | Lock screen (preserves lock muscle memory) |
| `Mod+Alt+C` | `spawn:noctalia msg panel-toggle session` | Power / session menu toggle |
| `Mod+Shift+W` | `spawn:noctalia msg panel-toggle wallpaper` | Wallpaper picker toggle |
| `Mod+V` | `spawn:noctalia msg panel-toggle clipboard` | Clipboard manager toggle |
| `Mod+N` | `spawn:noctalia msg panel-toggle control-center notifications` | Notification center toggle |
| `Mod+Tab` | `spawn:noctalia msg window-switcher` | Noctalia visual window switcher |
| `Alt+Tab` | `window-focus-next` | Traditional next-window focus cycling |

### 2.3 Window Management & Tiling Controls
| Key Chord | Action | Description |
| :--- | :--- | :--- |
| `Mod+Q` | `window-close` | Close active window (`repeat = false`) |
| `Mod+Shift+Q` | `window-kill` | Force kill active window (`repeat = false`) |
| `Mod+Shift+Escape`| `shortcuts-inhibit-toggle` | Toggle shortcuts inhibitor (`allow_when_inhibited = true`) |
| `Mod+T` | `window-toggle-floating` | Toggle floating state for active window |
| `Mod+D` | `window-toggle-maximize` | Toggle maximize active window |
| `Mod+Ctrl+F` | `window-toggle-maximize-to-edges` | Maximize to screen edges ignoring struts/bars |
| `Mod+F` | `window-toggle-fullscreen` | Fullscreen toggle |
| `Mod+Shift+P` | `window-toggle-pinned` | Pin window across all workspaces |
| `Mod+R` | `window-cycle-primary-extent` | Cycle scrolling column width forward (33% $\rightarrow$ 50% $\rightarrow$ 67%) |
| `Mod+Shift+R` | `window-cycle-primary-extent-back` | Cycle scrolling column width backward |

### 2.4 Focus & Window Movement
| Key Chord | Action |
| :--- | :--- |
| `Mod+Left` / `Right` | `window-focus-or-output-left` / `window-focus-or-output-right` |
| `Mod+Up` / `Down` | `window-focus-or-output-up` / `window-focus-or-output-down` |
| `Mod+Shift+Left` / `Right` | `window-move-or-output-left` / `window-move-or-output-right` |
| `Mod+Shift+Up` / `Down` | `window-move-or-output-up` / `window-move-or-output-down` |

### 2.5 Workspaces, Scrolling & Scratchpads
| Key Chord | Action | Details |
| :--- | :--- | :--- |
| `Mod+[1-9, 0]` | `workspace-switch:[1-10]` | Switch to workspace 1–10 |
| `Mod+Shift+[1-9, 0]` | `window-move-to-workspace:[1-10]` | Move active window and follow focus |
| `Mod+Shift+Alt+[1-9, 0]`| `window-move-to-workspace-silent:[1-10]` | Move active window silently |
| `Mod+Ctrl+Right` / `Left` | `workspace-next` / `workspace-previous` | Step to next/previous workspace |
| `Mod+Shift+Ctrl+Right` / `Left` | `window-move-to-workspace-next` / `window-move-to-workspace-previous` | Move window to next/previous workspace |
| `Mod+WheelDown` / `WheelUp` | `window-focus-right` / `window-focus-left` | Scroll strip focus with `cooldown_ms = 150` |
| `Mod+Ctrl+WheelDown` / `WheelUp` | `workspace-next` / `workspace-previous` | Step workspace on wheel with `cooldown_ms = 150` |
| `Mod+Shift+Ctrl+WheelDown` / `WheelUp` | `window-move-to-workspace-next` / `previous` | Move window workspace on wheel (`cooldown_ms = 150`) |
| `Mod+S` / `Mod+Shift+S` | `scratchpad-toggle:s` / `window-move-to-scratchpad:s` | Special scratchpad `s` |
| `Mod+A` / `Mod+Shift+A` | `scratchpad-toggle:magic` / `window-move-to-scratchpad:magic` | Special scratchpad `magic` |

### 2.6 Hardware Controls & Media (with `allow_when_locked = true`)
| Key Chord | Action / Command |
| :--- | :--- |
| `XF86AudioRaiseVolume` | `spawn:noctalia msg volume-up` |
| `XF86AudioLowerVolume` | `spawn:noctalia msg volume-down` |
| `XF86AudioMute` | `spawn:noctalia msg volume-mute` |
| `XF86AudioMicMute` | `spawn:noctalia msg mic-mute` |
| `XF86AudioPlay` / `Pause` | `spawn:noctalia msg media toggle` |
| `XF86AudioNext` / `Prev` | `spawn:noctalia msg media next` / `spawn:noctalia msg media previous` |
| `XF86MonBrightnessUp` / `Down` | `spawn:noctalia msg brightness-up` / `spawn:noctalia msg brightness-down` |

### 2.7 Screen Capture & Utilities
| Key Chord | Action / Command | Details |
| :--- | :--- | :--- |
| `Mod+P` | `spawn:hyprpicker -a -n` | Color picker tool (`repeat = false`) |
| `Print` | `spawn:noctalia msg screenshot-region` | Interactive region screenshot (`allow_when_locked = true`) |
| `Mod+Print` | `spawn:noctalia msg screenshot-fullscreen` | Fullscreen screenshot (`allow_when_locked = true`) |

---

## 3. Window & Layer Rules Implementation

Configured in [window-rules.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/window-rules.toml) and [layer-rules.toml](file:///home/pamod/dotfiles/umbriel/.config/umbriel/modules/layer-rules.toml):

### 3.1 Wallpaper Blur & Global Rules
- Global window wallpaper blur enabled:
  ```toml
  [[window_rule]]
  blur = true
  ```
- Picture-in-Picture floating:
  ```toml
  [[window_rule]]
  match.title = '^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture).*$'
  default_floating = true
  default_pinned = true
  default_floating_size = { width = 0.25, height = 0.25 }
  default_position = { x = 20, y = 20, anchor = 'bottom_right' }
  ```

### 3.2 Gaming & Application Routing
- **Games & VRR Monitor**:
  - `content_type = 'game'` $\rightarrow$ `default_output = 'HDMI-A-1'`
  - `xdg_tag = '^.*game.*$'` $\rightarrow$ `default_output = 'HDMI-A-1'`, `default_fullscreen = true`
  - `app_id = '^(steam_app.*|gamescope)$'` $\rightarrow$ `default_output = 'HDMI-A-1'`, `confine_pointer = true`
  - Steam auxiliary dialogs (Friends List, Launching, blank game launch stubs) float, center, and target `HDMI-A-1`.
- **Wine & Communication Routing**:
  - Windows executables (`app_id = '^.*\.exe$'`) float, center, and route to `eDP-1`.
  - Game launchers (`app_id = '^.*[Ll]auncher.*$'`) float and route to `eDP-1`.
  - Discord and Vesktop (`app_id = '^(vesktop|discord)$'`) route to `eDP-1`.

### 3.3 Dialogs, Portals & Thunar File Operations
- Standard modal dialogs float: `Open`, `Save As`, `Authentication Required`, `Choose Files`, `Confirm to replace files`, and `xdg-desktop-portal-gtk`.
- **Thunar Handling**:
  - Main Thunar window floats.
  - Transient dialogs (`match.is_dialog = true`) float.
  - Non-transient standalone file operations and progress windows (copying, moving, deleting, extracting, trash emptying) are matched via explicit title regex and set to float:
    ```toml
    [[window_rule]]
    match.app_id = '^thunar$'
    match.title = '^([Ff]ile [Oo]peration [Pp]rogress|[Cc]opying files|[Mm]oving files|[Dd]eleting files|[Cc]reating directories|[Cc]reating files|[Cc]reating symbolic links|[Cc]ollecting files|[Cc]alculating|[Cc]ancelling|[Aa]borting operation|[Ee]mptying the trash|[Rr]estoring files|[Vv]erifying file contents|[Pp]reparing|[Rr]esuming|[Ll]oading folder contents|[Pp]lease wait).*$'
    default_floating = true
    ```

### 3.4 Sized Floating Utilities
- Pavucontrol: `1160x811` px, centered.
- MPV: `1280x720` px, centered.
- Zathura PDF Viewer: centered float.
- qView Image Viewer: `1000x700` px, centered.
- Noctalia Settings App (`dev.noctalia.Noctalia`): `1100x750` px float.
- Ark Archiver: `40%x40%` float.
- GNOME Calculator: `25%x43%` float.
- Swash: `35%x35%` float.
- AB Download Manager (`com-abdownloadmanager-desktop-AppKt`):
  - Main window: `50%x90%` centered float.
  - Secondary windows/dialogs: float.

### 3.5 Zoom Workplace Glitch Fixes
Mitigates screen-share blocking and invisible popups:
- Main Zoom window floats.
- Sharing toolbar (`as_toolbar`, `annotate_toolbar`, `toolbar_window`, `cpt_share_buffer.*`): float, pinned, `default_focused = false`, `shadow = false`.
- Drawing canvas (`Annotate`, `Draw`): float, pinned, `default_focused = false`.
- Floating participant video pane (`zoom_linux_float_video_window`, `floating_video_window`): float, pinned, `default_focused = false`.
- Notification toasts (`ZPDrawingBufferWindow`, `notification_window`): float, pinned, `default_focused = false`, `shadow = false`.

### 3.6 Noctalia Layer Rules
- Layer namespaces (`noctalia-bar-*`, `notification`, `dock`, `panel`, `attached-panel`, `osd`, `desktop-widget-*`):
  - `blur = true`, `blur_ignore_alpha = 0.5`, `blur_popups = true`
- Overlays (panels, dock, notifications, OSD):
  - `blur_optimized = false` (forces live compositing blur over active windows instead of static wallpaper caching).

---

## 4. Idle & Lock Screen Reference

Compositor idle management and screen locking are handled through Noctalia's native Idle Service (`~/.local/state/noctalia/settings.toml`). No external `hypridle` or `hyprlock` daemons are run under Umbriel:

| Inactivity Duration | Hyprland Target | Noctalia Equivalent Setting |
| :--- | :--- | :--- |
| **150s (2.5m)** | Display brightness dim to 10 | Managed via Noctalia Power settings / `pre_action_fade_seconds` |
| **300s (5.0m)** | `loginctl lock-session` | `[idle.behavior.lock]` `timeout = 300.0` |
| **330s (5.5m)** | Display power off (`dpms off`) | `[idle.behavior.screen-off]` `timeout = 330.0` |
| **1800s (30m)** | System suspend (`systemctl suspend`) | `[idle.behavior.lock-and-suspend]` `timeout = 1800.0` |

---

## 5. Unsupported & Unported Features Analysis

| Hyprland Feature | Hyprland Implementation | Umbriel Equivalent / Architectural Resolution |
| :--- | :--- | :--- |
| **Window Swallowing** | `enable_swallow = true`, `swallow_regex = "(kitty...)"` | **Not Supported**. Umbriel lacks window swallowing architecture. CLI apps launched from terminal open in new columns or floating windows. |
| **Cursor Magnifier Binds** | Dynamic `hl.get_config("cursor:zoom_factor")` increment | **Not Supported**. Umbriel only supports zooming via the workspace overview. Arbitrary compositor cursor zoom keybinds are unavailable. |
| **Custom Directional 4-Finger Gestures** | 4-finger swipe down (close), up (fullscreen), left (float) | **Replaced by Native Gestures**. Umbriel hardcodes 3-finger horizontal gestures for workspace/strip scrolling and 4-finger gestures for overview toggle. Directional window actions cannot be bound to gestures. |
| **Persistent Window Resizing Across Sessions** | `persistent_size = true` | **Not Supported**. Window sizes reset when applications are closed and reopened unless matched by explicit `default_floating_size` rules. |
| **Regex `negative:` Matcher** | `initial_title = "negative:^(.*\\home\\.*)$"` | **Not Supported**. Umbriel uses ECMAScript regex syntax where `negative:` is invalid. Handled via declaration order (specific positive rules follow broader defaults). |
| **Inline `(?i)` Case-Insensitive Flag** | `thunarDialogTitle = "(?i)^(...).*$"` | **Not Supported**. ECMAScript regex doesn't support inline flags. Replaced by explicit character classes (`[Ff]ile`, `[Cc]opying`, etc.). |
| **Jump to Next Empty Workspace** | `hl.bind("Mod+Ctrl+Down", focus({ workspace = "emptym" }))` | **Omitted**. Umbriel provides `workspace-next` and `workspace-previous` actions, but lacks a discrete "focus first empty workspace" action. |
| **Active Border Angular Gradients** | `colors = { colors.green_light, colors.green_dark }, angle = 45` | **Solid Colors Only**. Umbriel supports solid border colors (`colors.border.focused = "#82dcccff"`). |
| **Discrete Inner vs. Outer Gaps** | `gaps_in = 3`, `gaps_out = 8` | **Unified Gap**. Umbriel uses a uniform `layout.gap = 8` spacing across all columns and borders. |
| **Direct Scanout in Outputs Schema** | `render.direct_scanout = 2` | **Compositor Managed**. Not defined in Umbriel's `[output]` table; VRR is supported per-output (`vrr = "fullscreen"`). |
| **Software Cursor Leak Workaround** | `no_hardware_cursors = 1` | **Dropped**. Umbriel runs standard hardware cursor compositing without external HDMI memory leaks. |
| **Global Active/Inactive Opacity** | `active_opacity = 0.95`, `inactive_opacity = 0.85` | **Intentionally Omitted**. Umbriel relies on wallpaper blur (`blur = true`) and opaque fullscreen windows rather than dimming inactive applications. |
| **Dwindle Split Toggling** | `Mod+J` $\rightarrow$ `layout("togglesplit")` | **Dropped**. Dwindle tree splits do not exist in Umbriel's horizontal scrolling layout. |
