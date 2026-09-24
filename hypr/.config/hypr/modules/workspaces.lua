local vars = require("modules.variables")

-- Workspace rules wiki https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- Add your workspace rules here. Increment the workspace number as you go. Do not have duplicate workspaces.
hl.workspace_rule({ workspace = "name:gaming", monitor = vars.monitors.primary })

-- hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1", default = true })
-- hl.workspace_rule({ workspace = "1", monitor = vars.monitors.one, default = true, persistent = true })

-- For other layouts such as scrolling, see example below
-- hl.workspace_rule({ workspace = "1", monitor = vars.monitors.one, default = true, persistent = true, layout = "scrolling" })
