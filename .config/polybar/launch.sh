#!/usr/bin/env bash

echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar | tee -a /tmp/polybar1.log & disown

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do	
	sleep 0.2
	MONITOR=$m polybar --reload example &
  done
else
  polybar --reload example &
fi

echo "Bars launched.."
