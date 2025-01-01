#!/usr/bin/env sh

SKETCHBAR_BIN="/opt/homebrew/bin/sketchybar"

used_disk_percentage=$(df -H | grep -E '^(/dev/disk3s1).' | awk '{ printf ("%s\n", $5) }')

$SKETCHBAR_BIN --set $NAME label="$used_disk_percentage"
