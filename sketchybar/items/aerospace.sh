SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12")

for sid in $(aerospace list-workspaces --all); do
	space_index=$((sid - 1))
	space=(
		icon="${SPACE_ICONS[space_index]}"
		icon.padding_left=10
		icon.padding_right=10
		padding_left=2
		padding_right=2
		label.padding_right=20
		icon.highlight_color=$RED
		label.color=$GREY
		label.highlight_color=$WHITE
		label.font="sketchybar-app-font:Regular:16.0"
		label.y_offset=-1
		background.color=0xff252630
		background.height=$BACKGROUND_HEIGHT
		background.corner_radius=$BACKGROUND_CORNER_RADIUS
		script="$CONFIG_DIR/plugins/aerospace.sh $sid"
	)
	echo "space.$sid: ${space[@]}"
	sketchybar --add item space.$sid left \
		--subscribe space.$sid aerospace_workspace_change \
		--set space.$sid "${space[@]}" \
		click_script="aerospace workspace $sid"
done

space_creator=(
	icon=􀆊
	icon.font="$FONT:Heavy:16.0"
	padding_left=10
	padding_right=8
	label.drawing=off
	display=active
	click_script='yabai -m space --create'
	script="$PLUGIN_DIR/aerospace_icons.sh"
	icon.color=$WHITE
)

sketchybar --add item space_creator left \
	--set space_creator "${space_creator[@]}" \
	--subscribe space_creator aerospace_workspace_change aerospace_focus_changed
