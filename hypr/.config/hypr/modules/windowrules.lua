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

hl.window_rule({
    name = "impala",
    match = { class = "impala", },
    float = true,
    size = "600 500",
    center = true
})

hl.window_rule({
    name = "pavucontrol",
    match = { class = "org.pulseaudio.pavucontrol", },
    float = true,
    size = "850 811",
    center = true
})

hl.window_rule({
    name = "blueman-manager",
    match = { class = "blueman-manager", },
    float = true,
    size = "600 750",
    center = true
})

hl.on("window.title", function(w)
    -- Wait until Firefox updates the window title to include "Bitwarden"
    if w.class == "firefox" and string.find(w.title, "Bitwarden", nil, true) then
        -- 1. Enable floating
        hl.dispatch(
            hl.dsp.window.float({ action = "enable", window = w })
        )
        -- 2. Apply your specific dimensions
        hl.dispatch(
            hl.dsp.window.resize({
                x = 450,
                y = 650,
                relative = false,
                window = w
            })
        )
        -- 3. Center it on the screen
        hl.dispatch(
            hl.dsp.window.center({ window = w })
        )
    end
end)
