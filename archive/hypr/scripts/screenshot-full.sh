#!/usr/bin/env bash
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

if grim "$FILE"; then
    wl-copy < "$FILE"
    notify-send -a "Grim" -u normal "Screenshot saved" "Full screen captured"
else
    notify-send -a "Grim" -u critical "Error" "Failed to capture full screen"
fi