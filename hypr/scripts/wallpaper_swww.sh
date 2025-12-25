#!/bin/bash
TIMEOUT=720

# Kill existing wallpaper processes
for pid in $(pgrep -f wallpaper_swww.sh | grep -v $$); do
    kill $pid
done

if ! [ -d ~/Pictures/wallpapers/ ]; then 
    notify-send -t 5000 "~/.config/hypr/wallpapers does not exist" && exit 1
fi

if [ $(ls -1 ~/Pictures/wallpapers/ | wc -l) -lt 1 ]; then	
    notify-send -t 9000 "The wallpaper folder is expected to have more than 1 image. Exiting Wallsetter." && exit 1
fi

while true; do
    while [ "$WALLPAPER" == "$PREVIOUS" ]; do
        WALLPAPER=$(find ~/Pictures/wallpapers/ -name '*' | awk '!/.git/' | tail -n +2 | shuf -n 1)
    done

    PREVIOUS=$WALLPAPER

    swww img "$WALLPAPER" --transition-type random
    wal -i $WALLPAPER -t -s 
    sleep $TIMEOUT
done
