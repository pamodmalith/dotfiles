#!/usr/bin/env bash
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

if grim "$FILE"; then
    wl-copy < "$FILE"
    notify-send "Screenshot saved" "Full screen captured"
else
    notify-send "Error" "Failed to capture full screen"
fi