#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpaper"
THUMBNAIL_DIR="$HOME/.cache/eww-wallpapers"

mkdir -p "$THUMBNAIL_DIR"

# Generate thumbnails for new wallpapers
for wallpaper in "$WALLPAPER_DIR"/*; do
  [ ! -f "$wallpaper" ] && continue
  thumbnail_path="$THUMBNAIL_DIR/$(basename "$wallpaper").png"
  if [ ! -f "$thumbnail_path" ]; then
    convert "$wallpaper[0]" -thumbnail 300x300^ -gravity center -extent 300x300 "$thumbnail_path"
  fi
done

# Output JSON array for Eww
find "$WALLPAPER_DIR" -type f | jq -R -s 'split("\n") | .[:-1] | map({
    "path": .,
    "thumb": "'$THUMBNAIL_DIR'/" + (split("/") | .[-1]) + ".png",
    "name": (split("/") | .[-1])
})'
