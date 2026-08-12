#!/usr/bin/env bash
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

# Get active window geometry using hyprctl and jq
GEOMETRY=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')

if grim -g "$GEOMETRY" "$FILE"; then
    wl-copy < "$FILE"
    notify-send -a "Grim" -u normal "Screenshot saved" "Active window captured"
else
    notify-send -a "Grim" -u critical "Error" "Failed to capture window"
fi