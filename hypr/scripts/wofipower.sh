#!/usr/bin/env bash


wofi_command="wofi --show dmenu \
			--prompt choose... \
			--cache-file=/dev/null \
			--hide-scroll --no-actions \
			--matching=fuzzy"

entries=$(echo -e " Poweroff\n Reboot\n Suspend\n Lock\n Logout" | $wofi_command -i --dmenu | awk '{print tolower($2)}')

case $entries in 
    poweroff|reboot|suspend)
        systemctl $entries
        ;;
    lock)
        $HOME/.config/hypr/scripts/screenlock.sh
        ;;
    logout)
        hyprctl dispatch exit 0
        ;;
esac
