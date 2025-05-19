#!/bin/bash

# wallpaper directory path
DIR=$HOME/Pictures/wallpapers

PICS=($(ls ${DIR} | grep -e ".jpg$" -e ".jpeg$" -e ".png$"))

# wofi_command="wofi --show dmenu --prompt choose... --cache-file=/dev/null --hide-scroll --no-actions -i"

menu(){
  for i in ${!PICS[@]}; do
    printf "img:${DIR}/${PICS[$i]}:text:${PICS[$i]}\n"
  done
}


main() {
    choice=$(menu | ${wofi_command} | cut -d: -f2)

    # no choice case
    if [[ -z $choice ]]; then return; fi

    echo ${choice} > $HOME/.config/wallpaperpath

    set_wallpaper
}


set_wallpaper() {
  local wallpaperpath

  if [ ! -f "$HOME/.config/wallpaperpath" ]; then
    wallpaperpath="$HOME/Pictures/wallpapers/default.png"
    echo ${wallpaperpath} > $HOME/.config/wallpaperpath
  else
    wallpaperpath=$(<$HOME/.config/wallpaperpath)
  fi

  # hyprctl hyprpaper preload "${wallpaperpath}"
  # hyprctl hyprpaper wallpaper ",${wallpaperpath}"
  swww ${wallpaperpath}

  exit 0
}

if [ $1 == "init" ]; then
  set_wallpaper
else
  main
fi

