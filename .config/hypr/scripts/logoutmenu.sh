#!/bin/bash

x=$(echo -e "Shutdown\nReboot\nReboot to Windows\nReboot to UEFI\nLogout\nSuspend\nHibernate" | fuzzel -d -p ": ")

if [  "$x" == "Shutdown" ]; then
	systemctl poweroff
elif [  "$x" == "Reboot" ]; then
	systemctl reboot
elif [  "$x" == "Reboot to Windows" ]; then
	echo "Reyyan1980" | sudo -S grub-reboot 2
	systemctl reboot
elif [  "$x" == "Suspend" ]; then
	systemctl suspend
elif [  "$x" == "Logout" ]; then
	hyprctl dispatch exit
elif [  "$x" == "Hibernate" ]; then
	systemctl hibernate
elif [  "$x" == "Reboot to UEFI" ]; then
	systemctl reboot --firmware-setup
fi

