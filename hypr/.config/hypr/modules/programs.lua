---------------------
---- MY PROGRAMS ----
---------------------

return {
  terminal      = "kitty",
  fileManager   = "thunar",
  browser       = "firefox",
  launcher      = "rofi -show drun -show-icons",
  menu          = "rofi -show run",
  clipboard     = "rofi -modi clipboard:~/.local/bin/cliphist-rofi-img -show clipboard -show-icons",
  reload_waybar = "~/.config/hypr/scripts/waybar-reload.sh",
  shutdown_hypr = "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'",
}
