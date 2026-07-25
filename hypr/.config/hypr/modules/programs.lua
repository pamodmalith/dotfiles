---------------------
---- MY PROGRAMS ----
---------------------

return {
  terminal            = "kitty",
  fileManager         = "thunar",
  browser             = "firefox",
  launcher            = "~/.config/rofi/scripts/launcher.sh",
  menu                = "rofi -show run",
  clipboard           = "rofi -modi clipboard:~/.local/bin/cliphist-rofi-img -show clipboard -show-icons",
  notification_center = "swaync-client -t",
  reload_waybar       = "~/.config/hypr/scripts/waybar-reload.sh",
  shutdown_hypr       = "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'",
}
