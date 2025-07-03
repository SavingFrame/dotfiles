#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

# Apply the selected wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"

selected_wallpaper=$(echo "$WALLPAPER" | sed 's/^img://')
wal -i "$selected_wallpaper" -n --cols16
swaync-client --reload-css
pywalfox update
