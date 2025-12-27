#!/usr/bin/env bash

CONFIG="$HOME/.config/waybar/hyprland.jsonc"
STYLE="$HOME/.config/waybar/hyprland.css"

# restart waybar
killall waybar
if [[ ! $(pidof waybar) ]]; then
  waybar --bar main-bar --log-level error --config ${CONFIG} --style ${STYLE} &> ~/.cache/waybar.log
fi
