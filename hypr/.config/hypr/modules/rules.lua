--------------------------------
---- APPLICATION WORKSPACES ----
--------------------------------

-- Browser
hl.window_rule({
  name = "firefox-workspace",
  match = {
    class = "firefox",
  },
  workspace = 1,
})

-- Terminal
hl.window_rule({
  name = "kitty-workspace",
  match = {
    class = "kitty",
  },
  workspace = 2,
})

-- VS Code
hl.window_rule({
  name = "vscode-workspace",
  match = {
    class = "code",
  },
  workspace = 3,
})

-- Thunar
hl.window_rule({
  name = "thunar-workspace",
  match = {
    class = "thunar",
  },
  workspace = 4,
})

-- Telegram
hl.window_rule({
  name = "telegram-workspace",
  match = {
    class = "org.telegram.desktop",
  },
  workspace = 5,
})

-- Vesktop
hl.window_rule({
  name = "vesktop-workspace",
  match = {
    class = "vesktop",
  },
  workspace = 8,
})
