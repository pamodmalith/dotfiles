#!/usr/bin/env bash
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name')

if grim -o "$MONITOR" "$FILE"; then
    wl-copy < "$FILE"
    notify-send "Screenshot saved" "$FILE"
else
    notify-send "Error" "Failed to capture monitor"
fi