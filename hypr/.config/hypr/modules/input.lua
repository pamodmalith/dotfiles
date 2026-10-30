---------------
---- INPUT ----
---------------

hl.config({
    input = {
        -- sensitivity = -0.25,
        accel_profile = "flat",
        touchpad     = {
            natural_scroll = true,
        },
        -- If editing input.lua (Lua syntax)
        kb_options = "compose:ralt,"
    },
    -- Software cursors enabled as a workaround for the compositor memory leak on
    -- mouse movement over the external HDMI monitor (see hyprwm/Hyprland#10918).
    -- If a future Hyprland release fixes the leak, this can be commented out again.
    cursor = {
        no_hardware_cursors = 1,
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "down",       action = "close" })
hl.gesture({ fingers = 4, direction = "up",         action = "fullscreen" })
hl.gesture({ fingers = 4, direction = "left",       action = "float" })

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
-- hl.device({
--     name        = "epic-mouse-v1",
--     sensitivity = -0.5,
-- })