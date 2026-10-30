local vars = require("modules.variables")

-- Window rules wiki https://wiki.hypr.land/Configuring/Basics/Window-Rules/

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Generic floating position
hl.window_rule({ match = { float = true }, persistent_size = true })

-- Picture-in-Picture
hl.window_rule({
    match             = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
    float             = true,
    keep_aspect_ratio = true,
    size              = { "max(monitor_w, monitor_h)*0.25", "min(monitor_w, monitor_h)*0.25" },
    pin               = true,
})

-- Gaming
local gamingApps = "^(steam_app.*|gamescope)$"
local gamingWorkspace = "name:gaming"

hl.window_rule({ match = { content = "game" }, workspace = gamingWorkspace })
hl.window_rule({ match = { xdg_tag = "^(.*game.*)$" }, workspace = gamingWorkspace, fullscreen_state = 2, content = "game", sync_fullscreen = true })
hl.window_rule({ match = { class = gamingApps }, workspace = gamingWorkspace })
hl.window_rule({ match = { class = "^(steam)$", title = "^(Friends List)$" }, float = true })
hl.window_rule({ match = { class = "^(steam)$", title = "^(Launching\\.{3})$" }, float = true, center = true, workspace = gamingWorkspace })
hl.window_rule({
    match = {
        class         = gamingApps,
        title         = "^(.+)$",
        initial_title = "negative:^(.*\\\\home\\\\.*)$",
    },
    content          = "game",
    decorate         = false,
    fullscreen_state = 2,
    size             = { "monitor_w", "monitor_h" },
    sync_fullscreen  = true,
})
hl.window_rule({
    match = {
        class         = "^(steam_app.*)$",
        initial_title = "^$",
    },
    center           = true,
    float            = true,
    fullscreen       = false,
    fullscreen_state = 0,
    workspace        = gamingWorkspace,
})

-- Apps
hl.window_rule({ match = { class = "^(.*\\.exe)$", float = true }, monitor = vars.monitors.primary, center = true, fullscreen_state = 0 })
hl.window_rule({ match = { class = "^(.*[Ll]auncher.*)$" }, float = true, monitor = vars.monitors.primary })
hl.window_rule({ match = { class = "^(vesktop|discord)$" }, monitor = vars.monitors.primary })
hl.window_rule({ match = { class = "^(.*[Cc]alc.*)$" }, float = true, size = { "max(monitor_w, monitor_h)*0.17", "min(monitor_w, monitor_h)*0.43" } })
hl.window_rule({ match = { class = "^(org\\.kde\\.keditfiletype)$" }, float = true })
hl.window_rule({ match = { class = "^(org\\.kde\\.ark)$" }, size = { "max(monitor_w, monitor_h)*0.40", "min(monitor_w, monitor_h)*0.40" } })
hl.window_rule({ match = { class = "^(.*swash)$", title = "^(Swash)$" }, min_size = { "max(monitor_w, monitor_h)*0.35", "min(monitor_w, monitor_h)*0.35" }, float = true })
hl.window_rule({ match = { class = "^(dev\\.)?(noctalia\\.Noctalia(\\.Settings)?)$" }, float = true, size = { "monitor_w*0.70", "monitor_h*0.70" } })

-- Float Common Modals
local modalMatches = {
    { title = "^(Open|Authentication Required|Add Folder to Workspace|Choose Files|Save As|Confirm to replace files|File Operation Progress)$" },
    { initial_title = "^(Open File)$" },
    { class = "^([Xx]dg-desktop-portal-gtk)$" },
    { title = "^(File Upload|Choose wallpaper|Library)(.*)$" },
    { class = "^(.*dialog.*)$" },
    { title = "^(.*dialog.*)$" },
    { class = "^(hyprland-share-picker)$"},
}
for _, m in ipairs(modalMatches) do hl.window_rule({ match = m, float = true }) end


-- Thunar
-- Rules are evaluated named-first, then anonymous, and the last matching rule
-- wins per effect. The main-window rule below is anonymous, so any dialog it
-- still matches would inherit its cursor-based `move`. Excluding dialog titles
-- here sends them to the dialog rule instead, which only floats them - Hyprland
-- then places them centered on their transient-for parent (the Thunar window)
-- instead of at the mouse cursor.
local thunarDialogPrefixes = {
    -- file operations and the progress window that reports them
    "file operation progress", "copying files", "moving files", "deleting files", "creating directories",
    "creating files", "creating symbolic links", "collecting files", "calculating", "cancelling",
    "aborting operation", "emptying the trash", "restoring files", "verifying file contents", "preparing",
    "resuming", "loading folder contents", "please wait",
    -- dialogs
    "create new folder", "create folder", "new folder", "new empty file", "open with", "other application",
    "select an application", "select an icon", "set default application", "move to trash", "delete", "rename*",
    "delete all files and folders in the trash", "bulk rename", "rename multiple files", "configure columns",
    "configure the toolbar", "file manager preferences", "about templates", "search with catfish", "Empty Trash",
    "select by pattern", "correct folder permissions", "extract", "compress", "move to", "copy to", "are you sure", "Attention",
}
local thunarPropertiesTail = " - properties" -- the properties dialog is titled "<file> - Properties"

-- Hyprland fully matches rule regexes, so every alternative has to span the
-- whole title. The prefixes above are plain words, so the same list doubles as
-- the matcher used by both rules below and the three cannot drift apart.
local thunarDialogTitle = "(?i)^(" .. table.concat(thunarDialogPrefixes, "|") .. "|.*" .. thunarPropertiesTail .. ").*$"

hl.window_rule({
    match = {
        class = "^thunar$",
        title = "negative:" .. thunarDialogTitle,
    },
    float = true,
    size = { "max(monitor_w, monitor_h)*0.50", "min(monitor_w, monitor_h)*0.55" },
    move = {
        "max(20, min(cursor_x - (window_w*0.50), monitor_w - window_w + 20))", -- X axis clamping
        "max(20, min(cursor_y - 50, monitor_h - window_h + 20))" -- Y axis clamping
    },
})

hl.window_rule({
    name = "thunar-dialog",
    match = {
        class = "^thunar$",
        title = thunarDialogTitle,
    },
    float = true,
})

-- Opacity Overrides
local terminals = "^(kitty|ghostty|[Kk]onsole|Alacritty|gnome-terminal|xfce[0-9]?-terminal)$"

hl.window_rule({ match = { class = "^(firefox|zen)$" }, opacity = "1.0 override" })
hl.window_rule({ match = { class = terminals }, opacity = "1.0 override" }) -- Override opacity in favor of terminal settings for opacity. If your terminal doesn't support transparency, you can remove this rule.
hl.window_rule({ match = { class = "^(mpv|org.kde.haruna|.*plex.*|org\\.kde\\.gwenview|.*vlc.*)$" }, opacity = "1.0 override" })

-- Float Utility Windows
local floatApps = {
    { class = "^(kvantummanager|qt[56]ct|nwg-look)$" },
    { class = "^(blueman-manager|nm-applet|nm-connection-editor)$" },
    { title = "^(Winetricks.*|Protontricks.*)$" },
}
for _, m in ipairs(floatApps) do hl.window_rule({ match = m, float = true }) end

-- Ignore maximize requests from all apps. You'll probably like this.
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Noctalia layer rule
hl.layer_rule({
  name = "noctalia",
  match = {
    namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
  },
  no_anim = true,
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
})

-- Apps that open as a centered floating window, optionally with a fixed size.
local sizedFloatApps = {
    { name = "pavucontrol", class = "org.pulseaudio.pavucontrol", size = "850 811" },
    { name = "mpv",         class = "mpv",                        size = "1280 720" },
    { name = "Zathura",     class = "org.pwmt.zathura" },
    { name = "qView",       class = "com.interversehq.qView",     size = "1000 700" },
}
for _, app in ipairs(sizedFloatApps) do
    hl.window_rule({
        name  = app.name,
        match = { class = app.class },
        float  = true,
        center = true,
        size   = app.size,
    })
end

-- ==================================
-- AB Download Manager (Compose Desktop, XWayland)
-- ==================================
local abDownloadManagerClass = "^com-abdownloadmanager-desktop-AppKt$"
local abDownloadManagerMainTitle = "^AB Download Manager$"

-- Keep the main window floating. A floating toplevel is what makes the app's
-- XWayland popups (menus, tooltips) and dialogs land on top of it instead of
-- being constrained by a tiled layout. Matching the title positively means the
-- forced size below can only ever land on the main window, never on a dialog.
hl.window_rule({
    name = "ab-download-manager",
    match = {
        class = abDownloadManagerClass,
        initial_title = abDownloadManagerMainTitle,
    },
    float = true,
    center = true,
    -- The app asks to be maximized on launch; without an explicit size a
    -- floating window would cover almost the whole monitor. The size is
    -- remembered afterwards by the global persistent_size rule above.
    size = { "monitor_w*0.50", "monitor_h*0.90" },
    suppress_event = "maximize",
})

-- Every other window of the class - dialogs ("Add Download", Settings, ...)
-- and real X11 popups (menus, dropdowns) - floats.
-- Only transient popups/menus (which have empty or generic titles) get
-- stay_focused to prevent them from closing immediately with follow-mouse focus.
-- Dialogs like "Add Download", Settings, etc. should NOT steal focus persistently.
hl.window_rule({
    name = "ab-download-manager-secondary",
    match = {
        class = abDownloadManagerClass,
        initial_title = "negative:" .. abDownloadManagerMainTitle,
    },
    float = true,
    no_anim = true,
})

-- Transient popups/menus (empty title or generic "menu"/"popup" titles) - keep focus
-- so they don't vanish immediately when mouse moves away in follow-mouse focus mode.
hl.window_rule({
    name = "ab-download-manager-popups",
    match = {
        class = abDownloadManagerClass,
        initial_title = "^(|menu|popup|dropdown|tooltip|Untitled)$",
    },
    float = true,
    stay_focused = true,
    no_anim = true,
})

-- ==================================
-- Zoom Workplace Hyprland Rules
-- ==================================

-- 1. Base rule: Always keep Zoom windows floating and prevent auto-maximize bugs
hl.window_rule({
  name = "zoom-general-float",
  match = { class = "^([Zz]oom|[Zz]oom [Ww]orkplace)$" },
  float = true,
  suppress_event = "maximize",
})

-- 2. FIX: Screen share toolbar & annotation/pen tool glitches
-- When the pen/annotation window or sharing toolbar opens, prevent Hyprland from 
-- expanding it, animating it, or taking keyboard focus away from the shared screen.
hl.window_rule({
  name = "zoom-sharing-toolbar",
  match = {
    class = "^([Zz]oom|[Zz]oom [Ww]orkplace)$",
    title = "^(as_toolbar|annotate_toolbar|toolbar_window|cpt_share_buffer.*)$",
  },
  float = true,
  pin = true,
  no_initial_focus = true,
  no_anim = true,
  no_shadow = true,
})

-- 3. FIX: Annotation canvas (drawing over screen) blowing up or tiling
hl.window_rule({
  name = "zoom-annotation-canvas",
  match = {
    class = "^([Zz]oom|[Zz]oom [Ww]orkplace)$",
    title = ".*(Annotate|annotation|Draw).*",
  },
  float = true,
  pin = true,
  no_initial_focus = true,
  no_anim = true,
})

-- 4. FIX: Dropdown menus & popup dialogs disappearing instantly on mouseover
hl.window_rule({
  name = "zoom-popups-stayfocused",
  match = {
    class = "^([Zz]oom|[Zz]oom [Ww]orkplace)$",
    initial_title = "^(menu window|Dropdown)$",
  },
  stay_focused = true,
  no_anim = true,
})

-- 5. Floating video thumbnails / participant picture-in-picture panes
hl.window_rule({
  name = "zoom-floating-video",
  match = {
    class = "^([Zz]oom|[Zz]oom [Ww]orkplace)$",
    title = "^(zoom_linux_float_video_window|floating_video_window)$",
  },
  float = true,
  pin = true,
  no_initial_focus = true,
})

-- 6. Notification toasts (e.g. "Recording in progress", reaction popups)
hl.window_rule({
  name = "zoom-notifications",
  match = {
    class = "^([Zz]oom|[Zz]oom [Ww]orkplace)$",
    title = "^(ZPDrawingBufferWindow|notification_window)$",
  },
  float = true,
  no_focus = true,
  no_anim = true,
  no_shadow = true,
  pin = true,
})
