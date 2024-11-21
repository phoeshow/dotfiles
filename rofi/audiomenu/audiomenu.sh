#!/usr/bin/env bash

dir="$HOME/.config/rofi/audiomenu"

# 音频设备
SINKS=$(pactl --format="json" list sinks | jq 'map([.index,.description])' | jq 'map(join(":"))' | jq '.[]' -r)

rofi_cmd() {
  rofi -dmenu \
       -p "Choose Device" \
       -theme ${dir}/theme.rasi
}

menu() {
  for i in ${!SINKS[@]};do
    printf "${SINKS[$i]}\n"
  done
}

choice=$(menu | rofi_cmd)


if [[ -z $choice ]]; then exit 0 ;fi
sink_index=$(echo $choice | cut -d: -f1)
pactl set-default-sink ${sink_index}
