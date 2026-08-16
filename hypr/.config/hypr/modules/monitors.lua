------------------
---- MONITORS ----
------------------

--------------------------------
---- LAPTOP DISPLAY ----
--------------------------------

hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "0x0",
    scale = "1",
})

--------------------------------
---- EXTERNAL DISPLAY ----
--------------------------------

hl.monitor({
    output = "HDMI-A-1",
    mode = "preferred",
    position = "auto-right",
    scale = "1",
})

-- Bind workspaces 1-5 to the laptop screen
hl.workspace_rule({ workspace = "1", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "6", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "7", monitor = "eDP-1" })

-- Bind workspaces 6-10 to the external HDMI monitor
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "9", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1" })
