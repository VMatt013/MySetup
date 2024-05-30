#!/bin/bash

selected=$(echo "󰤆  Shutdown
   Reboot
󰭖   Logout" | rofi -en -dmenu -p "Power" -i -show-icons)

if [[ "$selected" == *[Ss]hutdown ]]; then
	/sbin/shutdown now
elif [[ "$selected" == *[Rr]eboot ]]; then
	/sbin/reboot
elif [[ "$selected" == *[Ll]ogout ]]; then
	awesome-client "awesome.quit()"
fi
