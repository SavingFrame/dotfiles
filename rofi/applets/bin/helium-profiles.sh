#!/usr/bin/env bash

## Applets : Helium Profiles

set -euo pipefail

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

prompt=''
mesg='Choose profile for this link'
state="$HOME/.config/net.imput.helium/Local State"

if [[ ( "$theme" == *'type-1'* ) || ( "$theme" == *'type-3'* ) || ( "$theme" == *'type-5'* ) ]]; then
	list_col='1'
	list_row='3'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='3'
	list_row='1'
else
	list_col='1'
	list_row='3'
fi

profiles="$({
	python3 - "$state" <<'PY'
import json
import sys

with open(sys.argv[1], encoding='utf-8') as f:
    data = json.load(f)

profile = data.get('profile', {})
info = profile.get('info_cache', {})
order = profile.get('profiles_order') or list(info)

for directory in order:
    item = info.get(directory)
    if not item:
        continue
    name = item.get('name') or directory
    if name == 'Your Helium':
        continue
    print(f'{name}\t{directory}')
PY
} 2>/dev/null)"

if [[ -z "$profiles" ]]; then
	profiles=$'Default\tDefault'
fi

cursor_theme() {
	command -v hyprctl >/dev/null 2>&1 || return 0

	python3 <<'PY' 2>/dev/null || true
import json
import subprocess

cursor = subprocess.check_output(['hyprctl', 'cursorpos'], text=True).strip()
x, y = [int(part.strip()) for part in cursor.split(',', 1)]
monitors = json.loads(subprocess.check_output(['hyprctl', 'monitors', '-j'], text=True))

monitor = next(
    (
        item for item in monitors
        if item['x'] <= x < item['x'] + item['width'] and item['y'] <= y < item['y'] + item['height']
    ),
    next((item for item in monitors if item.get('focused')), monitors[0]),
)

width = 320
height = 190
margin = 12

x = min(max(x + margin, monitor['x'] + margin), monitor['x'] + monitor['width'] - width - margin)
y = min(max(y + margin, monitor['y'] + margin), monitor['y'] + monitor['height'] - height - margin)

print(f'window {{ location: northwest; anchor: northwest; x-offset: {x}px; y-offset: {y}px; width: {width}px; }}')
PY
}

rofi_cmd() {
	local placement
	placement="$(cursor_theme)"

	local args=(
		-theme-str "listview {columns: $list_col; lines: $list_row;}"
		-theme-str 'textbox-prompt-colon {str: "";}'
	)

	if [[ -n "$placement" ]]; then
		args+=(-theme-str "$placement")
	fi

	rofi "${args[@]}" \
		-me-select-entry '' \
		-me-accept-entry MousePrimary \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-theme "$theme"
}

chosen="$(printf '%s\n' "$profiles" | cut -f1 | rofi_cmd)"
[[ -z "$chosen" ]] && exit 0

profile_dir="$(printf '%s\n' "$profiles" | awk -F '\t' -v chosen="$chosen" '$1 == chosen {print $2; exit}')"
[[ -z "$profile_dir" ]] && exit 1

exec helium-browser --profile-directory="$profile_dir" "$@"
