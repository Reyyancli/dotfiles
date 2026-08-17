#!/bin/bash

x=$(echo -e "Shutdown\nReboot\nReboot to UEFI\nLogout\nSuspend\nHibernate" | dmenu -i -p "What do you want to do?")

if [  "$x" == "Shutdown" ]; then
	pkill obs
	systemctl poweroff
elif [  "$x" == "Reboot" ]; then
	pkill obs
	systemctl reboot
elif [  "$x" == "Suspend" ]; then
	pkill obs
	systemctl suspend
elif [  "$x" == "Logout" ]; then
	pkill obs
	i3-msg exit
elif [  "$x" == "Hibernate" ]; then
	pkill obs
	systemctl hibernate
elif [  "$x" == "Reboot to UEFI" ]; then
	pkill obs
	systemctl reboot --firmware-setup
fi

