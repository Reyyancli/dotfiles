#!/usr/bin/env bash

print_state() {
    if [ "$(dunstctl is-paused)" = "true" ]; then
        echo '{"text":"󰂛","alt":"dnd","class":"dnd","tooltip":"Do Not Disturb: on"}'
    else
        echo '{"text":"󰂚","alt":"normal","class":"normal","tooltip":"Do Not Disturb: off"}'
    fi
}

cleanup() { pkill -P $$ 2>/dev/null; }
trap cleanup EXIT
trap 'exit' TERM INT HUP

print_state

while read -r line; do
    [[ $line == *paused* ]] && print_state
done < <(exec gdbus monitor --session \
    --dest org.freedesktop.Notifications \
    --object-path /org/freedesktop/Notifications)
