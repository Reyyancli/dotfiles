#!/bin/bash

x=$(echo -e "Performance\nBalanced\nPower-Save" | dmenu -i -p "Set power profile")

if [ "$x" == "Performance" ]; then
	powerprofilesctl set performance
elif [ "$x" == "Balanced" ]; then
	powerprofilesctl set balanced
elif [ "$x" == "Power-Save" ]; then
	powerprofilesctl set power-saver
fi
