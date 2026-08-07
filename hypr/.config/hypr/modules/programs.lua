---------------------
---- MY PROGRAMS ----
---------------------

return {
  terminal            = "kitty",
  fileManager         = "thunar",
  browser             = "firefox",
  launcher            = "~/.config/rofi/scripts/launcher.sh",
  menu                = "rofi -show run",
  clipboard           = "rofi -modi clipboard:~/.config/rofi/scripts/cliphist-rofi-img -show clipboard -show-icons",
  notification_center = "swaync-client -t",
  reload_waybar       = "~/.config/hypr/scripts/waybar-reload.sh",
  screenshot_region   = "~/.config/hypr/scripts/screenshot-region.sh",
  screenshot_menu     = "~/.config/rofi/scripts/screenshot-menu.sh",
  screenshot_monitor  = "~/.config/hypr/scripts/screenshot-monitor.sh",
  shutdown_hypr       = "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'",
}
