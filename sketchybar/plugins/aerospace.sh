#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

source "$CONFIG_DIR/colors.sh"
is_focused_workspace=$([ "$1" = "$FOCUSED_WORKSPACE" ] && echo "true" || echo "false")

COLOR=$BACKGROUND_2
if [ "$is_focused_workspace" = "true" ]; then
	COLOR=$GREY
fi
sketchybar --set $NAME icon.highlight=$is_focused_workspace \
	label.highlight=$is_focused_workspace \
	background.border_color=$COLOR
