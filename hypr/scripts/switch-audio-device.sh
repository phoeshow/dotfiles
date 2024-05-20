#!/bin/bash

# SINKS=$(pactl list sinks short)
SINKS=$(pactl --format="json" list sinks | jq 'map([.index,.description])' | jq 'map(join(":"))' | jq '.[]' -r)

# wofi 运行命令行
wofi_command="wofi --show dmenu --prompt choose... --cache-file=/dev/null --hide-scroll --no-actions --matching=fuzzy"

menu() {
  for i in ${!SINKS[@]};do
    printf "${SINKS[$i]}\n"
  done
}

main() {
  choice=$(menu | ${wofi_command})
  # no choice case
  if [[ -z $choice ]]; then return ;fi

  sink_index=$(echo $choice | cut -d: -f1)
  pactl set-default-sink ${sink_index}
}

if pidof wofi >/dev/null; then
  killall wofi
  exit 0
else
  main
fi
