#!/bin/bash

while true; do
  BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT1/capacity)
  BATTERY_STATUS=$(cat /sys/class/power_supply/BAT1/status)

  if [[ "$BATTERY_STATUS" == "Charging" && "$BATTERY_LEVEL" -ge 80 ]]; then
    notify-send -u critical "Battery at $BATTERY_LEVEL%" "Unplug the charger to preserve battery health."
    sleep 300 # Wait 5 minutes before warning again
  elif [[ "$BATTERY_STATUS" == "Discharging" && "$BATTERY_LEVEL" -le 20 ]]; then
    notify-send -u critical "Battery at $BATTERY_LEVEL%" "Plug in the charger to avoid deep discharge."
    sleep 300
  else
    sleep 60 # Check every minute
  fi
done