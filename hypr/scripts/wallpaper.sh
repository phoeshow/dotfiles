#!/bin/bash

# wallpaper directory path
DIR=$HOME/Pictures/wallpapers

PICS=($(ls ${DIR} | grep -e ".jpg$" -e ".jpeg$" -e ".png$"))

wofi_command="wofi --show dmenu --prompt choose... --cache-file=/dev/null --hide-scroll --no-actions --matching=fuzzy"

menu(){
  for i in ${!PICS[@]}; do
    printf "$i. ${PICS[$i]}\n"
  done
}


main() {
    choice=$(menu | ${wofi_command})

    # no choice case
    if [[ -z $choice ]]; then return; fi
    
    pic_index=$(echo $choice | cut -d. -f1)
    real_wallpaper_path=${DIR}/${PICS[$pic_index]}

    echo ${real_wallpaper_path} > $HOME/.config/wallpaperpath

    set_wallpaper
}


set_wallpaper() {
  local wallpaperpath=""

  if [ ! -f "$HOME/.config/wallpaperpath" ]; then
    wallpaperpath="$HOME/Pictures/wallpapers/default.png"
    echo ${wallpaperpath} > $HOME/.config/wallpaperpath
  else
    wallpaperpath=$(<$HOME/.config/wallpaperpath)
  fi

  if pidof swaybg > /dev/null; then
    killall swaybg
  fi
  swaybg -m fill -i ${wallpaperpath}
}

if pidof wofi >/dev/null; then
  killall wofi
  exit 0
elif [ $1 == "init" ]; then
  set_wallpaper
else
  main
fi
