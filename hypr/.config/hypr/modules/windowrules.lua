--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

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

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

--------------------------------
---- FLOATING WINDOWS ----
--------------------------------

-- Authentication dialogs
hl.window_rule({
    name = "polkit-dialog",
    match = {
        class = "polkit",
    },
    float = true,
    center = true,
})

-- File picker dialogs
hl.window_rule({
    name = "file-dialog",
    match = {
        title = "Open File|Save File",
    },
    float = true,
    center = true,
    border_size = 1,
    size = { 900, 700 },
})

-- Picture in Picture
hl.window_rule({
    name = "picture-in-picture",
    match = {
        title = "Picture-in-Picture",
    },
    float = true,
    pin = true,
})

-- Impala for managing wifi connections
hl.window_rule({
    name = "impala",
    match = { class = "impala", },
    float = true,
    size = "600 500",
    center = true
})

-- Pavucontrol for volume control
hl.window_rule({
    name = "pavucontrol",
    match = { class = "org.pulseaudio.pavucontrol", },
    float = true,
    size = "850 811",
    center = true
})

-- Blueman for bluetooth management
hl.window_rule({
    name = "blueman-manager",
    match = { class = "blueman-manager", },
    float = true,
    size = "600 750",
    center = true
})

-- Handle Firefox popups that change their title dynamically (Bitwarden, Google Auth, etc.)
hl.on("window.title", function(w)
    if w.class == "firefox" then
        -- 1. Check for Bitwarden
        if string.find(w.title, "Bitwarden", nil, true) then
            hl.dispatch(hl.dsp.window.float({ action = "enable", window = w }))
            hl.dispatch(hl.dsp.window.resize({ x = 450, y = 650, relative = false, window = w }))
            hl.dispatch(hl.dsp.window.center({ window = w }))

            -- 2. Check for Google Sign-in popups
        elseif string.find(w.title, "Sign in – Google accounts", nil, true) then
            hl.dispatch(hl.dsp.window.float({ action = "enable", window = w }))
            hl.dispatch(hl.dsp.window.resize({ x = 500, y = 650, relative = false, window = w }))
            hl.dispatch(hl.dsp.window.center({ window = w }))
        end
    end
end)

hl.window_rule({
    name = "mpv",
    match = { class = "mpv" },
    float = true,
    size = "1280 720",
    center = true
})


-- Steam overlay
-- Fix Steam pop-ups and child windows
hl.window_rule({
    name = "steam-special-offers-float",
    match = {
        class = "^(steam)$",
        title = "^(Special Offers)$"
    },
    float = true
})

hl.window_rule({
    name = "steam-friends-float",
    match = {
        class = "^(steam)$",
        title = "^(Friends List)$"
    },
    float = true
})

hl.window_rule({
    name = "steam-news-float",
    match = {
        class = "^(steam)$",
        title = "^(Steam - News)$"
    },
    float = true
})
