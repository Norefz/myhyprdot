#!/bin/bash

ICON_CHARGING="$HOME/.local/bin/icons/battery_charging.png"
ICON_DISCHARGING="$HOME/.local/bin/icons/battery_discharging.png"
ICON_LOW="$HOME/.local/bin/icons/low-battery.png"
ICON_CRITICAL="$HOME/.local/bin/icons/low-battery.png"

BAT_PATH=$(find /sys/class/power_supply/ -name "BAT*" | head -n 1)

LOW_BATTERY=20
CRITICAL_BATTERY=10

# Initial state
LAST_STATUS=$(cat "$BAT_PATH/status")
LAST_NOTIFIED_LEVEL=0

while true; do
  BATTERY_LEVEL=$(cat "$BAT_PATH/capacity")
  BATTERY_STATUS=$(cat "$BAT_PATH/status")

  # 1. Power Connection Changes
  if [ "$BATTERY_STATUS" != "$LAST_STATUS" ]; then
    if [ "$BATTERY_STATUS" = "Charging" ]; then
      notify-send -u normal -i "$ICON_CHARGING" "Power Connected" "Battery is charging ($BATTERY_LEVEL%)"
    elif [ "$BATTERY_STATUS" = "Discharging" ]; then
      notify-send -u normal -i "$ICON_DISCHARGING" "Power Disconnected" "Running on battery ($BATTERY_LEVEL%)"
    fi
    LAST_STATUS=$BATTERY_STATUS
  fi

  # 2. Low/Critical Alerts
  if [ "$BATTERY_STATUS" = "Discharging" ] && [ "$BATTERY_LEVEL" != "$LAST_NOTIFIED_LEVEL" ]; then
    if [ "$BATTERY_LEVEL" -le "$CRITICAL_BATTERY" ]; then
      notify-send -u critical -i "$ICON_CRITICAL" "CRITICAL BATTERY" "Level: $BATTERY_LEVEL%!"
      LAST_NOTIFIED_LEVEL=$BATTERY_LEVEL
    elif [ "$BATTERY_LEVEL" -le "$LOW_BATTERY" ]; then
      notify-send -u normal -i "$ICON_LOW" "Low Battery" "Level: $BATTERY_LEVEL%"
      LAST_NOTIFIED_LEVEL=$BATTERY_LEVEL
    fi
  fi

  sleep 1
done
