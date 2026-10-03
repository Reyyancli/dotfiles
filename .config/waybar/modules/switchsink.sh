#!/usr/bin/env sh

# Sinks to skip (case-insensitive extended regex, matched against the sink name)
IGNORE='sunshine|loopback'

# Names of all sinks except the ignored ones
sinks=$(pactl list sinks | awk -v ign="$IGNORE" '
    /^[ \t]*Name:/ { name = $2 }
    /^[ \t]*Description:/ {
        desc = $0
        sub(/^[ \t]*Description: /, "", desc)
        if (tolower(name " " desc) !~ ign) print name
    }')
if [ -z "$sinks" ]; then
    notify-send "No usable sinks found"
    exit 1
fi

current_sink=$(pactl get-default-sink)

# Position of the current sink in the filtered list (exact match).
# Empty if the current sink is an ignored one, in which case we start at the first.
current_n=$(echo "$sinks" | grep -nxF -- "$current_sink" | cut -d: -f1)
count=$(echo "$sinks" | wc -l)
next_n=$(( ${current_n:-0} % count + 1 ))

new_sink=$(echo "$sinks" | sed -n "${next_n}p")
pactl set-default-sink "$new_sink"

# Move any currently playing streams to the new sink so they follow immediately
for input in $(pactl list short sink-inputs | cut -f1); do
    pactl move-sink-input "$input" "$new_sink" 2>/dev/null
done

# Look up the human-readable description and strip some noise
new_sink_name=$(pactl list sinks | awk -v name="$new_sink" '
    /^[ \t]*Name:/        { found = ($2 == name) }
    found && /^[ \t]*Description:/ {
        sub(/^[ \t]*Description: /, "")
        print
        exit
    }' | sed -E 's/ *(Stereo|Analog|Digital|Controller).*//')

notify-send "Using sink ${new_sink_name:-$new_sink}"
