---------------------
----- VARIABLES -----
---------------------

local M = {}

M.apps = {
  -- Core GUI
  terminal            = "kitty",
  file_manager        = "thunar",
  browser             = "firefox",
  editor              = "gnome-text-editor --new-window",
  calculator          = "gnome-calculator",
}

-- Monitor / Display Setup
M.monitors = {
  one   = "eDP-1",
  two   = "HDMI-1",
  primary   = "eDP-1",
}

-- Workspaces Setup
M.workspaces = {
  per_monitor = 10,
}

return M