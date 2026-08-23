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

-- Intellij IDEA
hl.window_rule({
  name = "intellij-workspace",
  match = {
    class = "jetbrains-idea",
  },
  workspace = 3,
})

-- Netbeans
hl.window_rule({
  name = "netbeans-workspace",
  match = {
    class = "Apache NetBeans IDE 30",
    title = "Apache NetBeans IDE 30",
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

-- Spotify
hl.window_rule({
  name = "spotify-workspace",
  match = {
    class = "Spotify",
  },
  workspace = 7,
})

-- OBS
hl.window_rule({
  name = "obs-workspace",
  match = {
    class = "com.obsproject.Studio",
  },
  workspace = 8,
})

-- Vesktop
hl.window_rule({
  name = "vesktop-workspace",
  match = {
    class = "vesktop",
  },
  workspace = 9,
})

-- Steam
hl.window_rule({
  name = "steam-workspace",
  match = {
    class = "steam",
  },
  workspace = 10,
})
