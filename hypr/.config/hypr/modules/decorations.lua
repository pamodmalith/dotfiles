-- Look and feel configuration

local colors = require("modules.colors")

hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 8,
        border_size = 2,
        extend_border_grab_area = 10,
        resize_on_border = true,
        col = {
            active_border = {
                colors = { colors.CACHYLGREEN, colors.CACHYDGREEN },
                angle = 45,
            },
            inactive_border = colors.CACHYGRAY,
        },
    },
    group = {
        col = {
            border_active = colors.CACHYLBLUE,
            border_inactive = colors.CACHYGRAY,
            border_locked_active = colors.CACHYDBLUE,
            border_locked_inactive = colors.CACHYGRAY,
        },
        groupbar = {
            col = {
                active = colors.CACHYLGREEN,
                inactive = colors.CACHYGRAY,
                locked_active = colors.CACHYDBLUE,
                locked_inactive = colors.CACHYGRAY,
            },
        },
    },
    decoration = {
        dim_special = 0.3,
        rounding = 10,
        active_opacity = 0.95,
        inactive_opacity = 0.85,
        fullscreen_opacity = 1,
        blur = {
            size = 5,
            passes = 4,
            special = true,
        },
    },
})
