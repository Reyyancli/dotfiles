#!/bin/bash

x=$(echo -e "Shutdown\nReboot\nReboot to UEFI\nLogout\nSuspend\nHibernate" | fuzzel -d -p ": ")

if [  "$x" == "Shutdown" ]; then
	systemctl poweroff
elif [  "$x" == "Reboot" ]; then
	systemctl reboot
elif [  "$x" == "Suspend" ]; then
	systemctl suspend
elif [  "$x" == "Logout" ]; then
	niri msg action quit
elif [  "$x" == "Hibernate" ]; then
	systemctl hibernate
elif [  "$x" == "Reboot to UEFI" ]; then
	systemctl reboot --firmware-setup
fi

