#!/bin/bash

# --- GLOBAL CONFIGURATION ---
WALL_DIR="$HOME/Pictures/wallpaper"
CACHE_DIR="$HOME/.cache/rofi-walls"
EWW_CMD="/home/erlan/.local/bin/eww"
HYPRLOCK_SYMLINK="$HOME/.config/hypr/current_hyprlock_wallpaper.jpg"

# Ensure cache directory exists for optimized performance
mkdir -p "$CACHE_DIR"

# --- CORE FUNCTIONS ---

# Generate high-performance thumbnails for Rofi's UI
# Uses ImageMagick v7 to create portrait-oriented crops
generate_thumbnails() {
  find "$WALL_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \) | while read -r img; do
    fn=$(basename "$img")
    if [ ! -f "$CACHE_DIR/$fn" ]; then
      # Optimized for portrait aspect ratio: 300x500
      magick "$img" -strip -resize "x500^" -gravity center -extent 300x500 "$CACHE_DIR/$fn"
    fi
  done
}

# Construct the formatted string list for Rofi dmenu
# Icons are fetched from the local cache directory
fetch_wallpapers() {
  find "$WALL_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.webp" \) | while read -r path; do
    fn=$(basename "$path")
    echo -en "$fn\0icon\x1f$CACHE_DIR/$fn\n"
  done
}

# Initial execution: sync thumbnails
generate_thumbnails

# --- USER INTERACTION ---
# Execute Rofi with custom theme and capture user selection
selection=$(fetch_wallpapers | rofi -dmenu -i -p "󰸉 Select Wallpaper" -theme "$HOME/.config/rofi/wallchanger//wall_theme.rasi")

# --- POST-SELECTION LOGIC ---
if [ -n "$selection" ]; then
  FULL_PATH="$WALL_DIR/$selection"

  # 1. Apply wallpaper via swww with transition effects
  swww img "$FULL_PATH" --transition-type wipe --transition-angle 30 --transition-step 90

  # 2. Update system colorscheme via Pywal
  wal -i "$FULL_PATH" -n -q

  # 3. Synchronize third-party application themes
  pywal-discord -d vencord &

  # 4. Refresh Notification Daemon (SwayNC) style and config
  swaync-client -rs &
  swaync-client -R &

  # 5. Update Hyprlock wallpaper reference via symbolic link
  rm -f "$HYPRLOCK_SYMLINK"
  ln -s "$FULL_PATH" "$HYPRLOCK_SYMLINK"

  # 6. Dispatch system notification for confirmation
  notify-send "Environment Updated" "Wallpaper set to: $selection" -i "$FULL_PATH" -a "System" --hint=string:resident:false

fi
