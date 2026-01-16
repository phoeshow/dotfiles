#!/usr/bin/env bash

toggle_mute() {
  if [ "$(pamixer --get-mute)" == "false" ]; then
    pamixer -m;
    # dunstify -h string:x-canonical-private-synchronous:audio "Mute:ON" --icon=audio-volume-muted
    notify-send -h string:x-canonical-private-synchronous:audio "Mute:ON" --icon=audio-volume-muted
  elif [ "$(pamixer --get-mute)" == "true" ]; then
    pamixer -u;
    # dunstify -h string:x-canonical-private-synchronous:audio "Mute:OFF" --icon=audio-volume-medium
    notify-send -h string:x-canonical-private-synchronous:audio "Mute:OFF" --icon=audio-volume-medium
  fi
}

toggle_mic() {
  if [ "$(pamixer --default-source --get-mute)" == "false" ]; then
    pamixer --default-source -m
  elif [ "$(pamixer --default-source --get-mute)" == "true" ]; then
    pamixer --default-source -u
  fi
}

increase_vol() {
  pamixer -i 2;
  local volume=$(pamixer --get-volume)
  # dunstify -h string:x-canonical-private-synchronous:audio "Volume" -h int:value:$(pamixer --get-volume) --icon=audio-volume-high
  notify-send -t 1000 -a 'wp-vol' -h string:x-canonical-private-synchronous:volume -h int:value:$volume "Volume: ${volume}%"
}

decrease_vol() {
  pamixer -d 2;
  local volume=$(pamixer --get-volume)
  # dunstify -h string:x-canonical-private-synchronous:audio "Volume" -h int:value:$(pamixer --get-volume) --icon=audio-volume-low
  notify-send -t 1000 -a 'wp-vol' -h string:x-canonical-private-synchronous:volume -h int:value:$volume "Volume: ${volume}%"
}


if [[ "$1" == "--toggle" ]];then
  toggle_mute
elif [[ "$1" == "--toggle-mic" ]];then
  toggle_mic
elif [[ "$1" == "--increase_vol" ]];then
  increase_vol
elif [[ "$1" == "--decrease_vol" ]];then
  decrease_vol
fi


