#!/bin/bash

toggle_mute() {
  if [ "$(pamixer --get-mute)" == "false" ]; then
    pamixer -m;
  elif [ "$(pamixer --get-mute)" == "true" ]; then
    pamixer -u;
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
  dunstify "Volume" -h int:value:$(pamixer --get-volume)
}

decrease_vol() {
  pamixer -d 2;
  dunstify "Volume" -h int:value:$(pamixer --get-volume)
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


