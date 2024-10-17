#!/bin/bash

if [ "$SENDER" = "space_windows_change" ]; then
	space="$(echo "$INFO" | jq -r '.space')"
	apps="$(echo "$INFO" | jq -r '.apps | keys[]')"
	echo "apps: $apps"
	icon_strip=" "
	if [ "${apps}" != "" ]; then
		while read -r app; do
			icon_strip+=" $($CONFIG_DIR/plugins/icon_map.sh "$app")"
		done <<<"${apps}"
	else
		icon_strip=" —"
	fi
	sketchybar --animate sin 10 --set space.$space label="$icon_strip"
fi
