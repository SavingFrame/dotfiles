#!/bin/sh
# Aggregate Pi states across all panes in a window, including inactive panes.
# Arguments: window ID, tmux socket path.
[ "$#" -eq 2 ] || exit 0
state=$(tmux -S "$2" list-panes -t "$1" -F '#{@pi_status}' 2>/dev/null | awk '
BEGIN { rank["idle"]=1; rank["done"]=2; rank["working"]=3; rank["blocked"]=4; rank["error"]=5 }
rank[$0] > best { best=rank[$0]; state=$0 }
END { print state }
')
case "$state" in
  working)
    frame=$(($(date +%s) % 8))
    case "$frame" in
      0) icon='⠋';; 1) icon='⠙';; 2) icon='⠹';; 3) icon='⠸';;
      4) icon='⠼';; 5) icon='⠴';; 6) icon='⠦';; 7) icon='⠧';;
    esac
    color='#80a0ff';;
  blocked) icon='?'; color='#f09479';;
  done) icon='✓'; color='#8cc85f';;
  error) icon='✗'; color='#e65e72';;
  idle) icon='○'; color='#9c9c9c';;
  *) exit 0;;
esac
printf ' #[fg=%s]%s#[fg=default]' "$color" "$icon"
