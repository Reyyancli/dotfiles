#!/usr/bin/env bash

# converts time so it's human readable
now_mono=$(python3 -c 'import time; print(int(time.monotonic()*1e6))')
now_wall=$(date +%s)

entries=$(dunstctl history | jq -r --argjson nm "$now_mono" --argjson nw "$now_wall" '
  .data[0][]
  | ($nw - (($nm - .timestamp.data) / 1000000 | floor)) as $t
  | "\(.id.data)\t\($t | strflocaltime("%a %H:%M"))  \(.appname.data): \(.summary.data) — \(.body.data | gsub("\n"; " "))"')

if [ -z "$entries" ]; then
    notify-send "Notification history is empty"
    exit
fi

choice=$(printf '%s\n%s\n' "$entries" $'clear\t󰎟  Clear history' \
    | fuzzel --dmenu --with-nth=2 --accept-nth=1 -w 70)

case $choice in
    clear) dunstctl history-clear ;;
    '')    ;;
    *)     dunstctl history-pop "$choice" ;;
esac
