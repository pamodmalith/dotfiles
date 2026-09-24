#!/usr/bin/env bash

DIR="$HOME/Pictures/Screenshots"

mkdir -p "$DIR"

FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

if grim -g "$(slurp)" "$FILE"; then
    wl-copy < "$FILE"
    notify-send -a "Grim" -u normal "Screenshot saved" "$FILE"
else
    notify-send -a "Grim" -u critical "Error" "Failed to capture screenshot"
fi