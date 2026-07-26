#!/usr/bin/env bash

# Define the options
OPTIONS="1. Region\n2. Full Screen\n3. Active Window"

# Pipe them into rofi
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Screenshot" -lines 3)

# Execute the corresponding script based on the selection
case "$CHOICE" in
    "1. Region")
        ~/.config/hypr/scripts/ss-region.sh
        ;;
    "2. Full Screen")
        sleep 0.3 && ~/.config/hypr/scripts/ss-full.sh
        ;;
    "3. Active Window")
        sleep 0.3 && ~/.config/hypr/scripts/ss-window.sh
        ;;
esac