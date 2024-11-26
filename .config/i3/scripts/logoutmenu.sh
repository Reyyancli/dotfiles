#!/bin/bash

x=$(echo -e "Shutdown\nReboot\nLogout\nSuspend\nHibernate" | dmenu -i -p "What do you want to do?")

if [  "$x" == "Shutdown" ]; then
	systemctl poweroff
elif [  "$x" == "Reboot" ]; then
	systemctl reboot
elif [  "$x" == "Suspend" ]; then
	systemctl suspend
elif [  "$x" == "Logout" ]; then
	i3-msg exit
elif [  "$x" == "Hibernate" ]; then
	systemctl hibernate
fi

