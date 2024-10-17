#!/bin/bash

if [ "$SENDER" = "aerospace_workspace_change" ] || [ "$SENDER" = "aerospace_focus_changed" ]; then
	space="$FOCUSED_WORKSPACE"
	# apps="$(echo "$INFO" | jq -r '.apps | keys[]')"
	apps=$(aerospace list-windows --workspace $space --format %{app-name})

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
