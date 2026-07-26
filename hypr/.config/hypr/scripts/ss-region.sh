#!/usr/bin/env bash

DIR="$HOME/Pictures/Screenshots"

mkdir -p "$DIR"

FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

if grim -g "$(slurp)" "$FILE"; then
    wl-copy < "$FILE"
    notify-send "Screenshot saved" "$FILE"
else
    notify-send "Error" "Failed to capture screenshot"
fi