local vars = require("config.variables")

-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
    output    = vars.monitors.one,
    mode      = "1920x1080@60",
    position  = "0x0",
    scale     = "1",
})


hl.monitor({
    output    = vars.monitors.two,
    mode      = "preferred",
    position  = "auto",
    scale     = "1",
})
