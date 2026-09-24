local colors = require("config.colors")

-- Look and feel configuration

hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 8,
        border_size = 2,
        extend_border_grab_area = 10,
        resize_on_border = true,
        col = {
            active_border = {
                colors = { colors.green_light, colors.green_dark },
                angle = 45,
            },
            inactive_border = colors.grey,
        },
    },
    group = {
        col = {
            border_active = colors.blue_light,
            border_inactive = colors.grey,
            border_locked_active = colors.blue_dark,
            border_locked_inactive = colors.grey,
        },
        groupbar = {
            col = {
                active = colors.green_light,
                inactive = colors.grey,
                locked_active = colors.blue_dark,
                locked_inactive = colors.grey,
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
