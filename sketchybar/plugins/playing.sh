#!/usr/bin/env bash

SKETCHBAR_BIN="/opt/homebrew/bin/sketchybar"

PLAYING=$(cd ~/.config/sketchybar/spotify && ./song.sh)
ARTIST=$(cd ~/.config/sketchybar/spotify && ./artist.sh)
BOTH=$(echo $PLAYING && echo "| |" && echo $ARTIST)
FINAL=$(echo $BOTH | sed 's/\(.\{22\}\).*/\1.../')
#FINAL=$(echo $PLAYING | sed 's/\(.\{20\}\).*/\1.../')

sketchybar --set $NAME icon="  " label=" $FINAL"
