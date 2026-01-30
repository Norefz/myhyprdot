#!/bin/bash

WIDTH=$(hyprctl monitors -j | jq '.[0].width')
THRESHOLD=$((WIDTH - 2))

while true; do
  CURSOR_X=$(hyprctl cursorpos -j | jq '.x')

  if [ "$CURSOR_X" -ge "$THRESHOLD" ]; then
    swaync-client -t -sw
    sleep 2
  fi
  sleep 0.2
done
