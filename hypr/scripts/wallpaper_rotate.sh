#!/usr/bin/env bash

TIMEOUT=720
WALLPAPER_SCRIPT="$HOME/.config/hypr/scripts/wallpaper_awww.sh"
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Kill existing wallpaper rotation processes
for pid in $(pgrep -f "$(basename "$0")" | grep -v "^$$$"); do
    kill "$pid" 2>/dev/null
done

if [ ! -x "$WALLPAPER_SCRIPT" ]; then
    echo "Wallpaper script not executable: $WALLPAPER_SCRIPT"
    exit 1
fi

if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "$WALLPAPER_DIR does not exist"
    exit 1
fi

if [ "$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | wc -l)" -lt 1 ]; then
    echo "The wallpaper folder must contain at least 1 image"
    exit 1
fi

while true; do
    current=""
    [ -f "$HOME/.cache/current_wallpaper" ] && current=$(cat "$HOME/.cache/current_wallpaper" 2>/dev/null)

    while [ -z "${wallpaper:-}" ] || [ "$wallpaper" = "$current" ]; do
        wallpaper=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)
    done

    "$WALLPAPER_SCRIPT" "$wallpaper"
    wallpaper=""
    sleep "$TIMEOUT"
done
