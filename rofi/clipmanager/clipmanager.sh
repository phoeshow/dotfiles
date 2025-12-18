#!/usr/bin/env bash

CONFIG_PATH="$HOME/.config/rofi/clipmanager/theme.rasi"

rofi_cmd() {
  rofi -dmenu \
       -p "Choose Item" \
       -theme ${CONFIG_PATH}
}

choice=$(cliphist list | rofi_cmd | cliphist decode | wl-copy)


if [[ -z $choice ]]; then exit 0 ;fi
