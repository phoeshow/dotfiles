#!/bin/bash

# wallpaper directory path
DIR=$HOME/Pictures/wallpapers

PICS=($(ls ${DIR} | grep -e ".jpg$" -e ".jpeg$" -e ".png$"))

wofi_command="wofi --show dmenu --prompt choose... --cache-file=/dev/null --hide-scroll --no-actions --matching=fuzzy"

menu(){
  for i in ${!PICS[@]}; do
    printf "${PICS[$i]}\n"
  done
}


main() {
    choice=$(menu | ${wofi_command})

    # no choice case
    if [[ -z $choice ]]; then return; fi

    real_wallpaper_path=${DIR}/${choice}

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

  exit 0
}

random_wallpaper() {
  local target_directory="$HOME/Pictures/wallpapers"
  local image_files=($(find "$target_directory" -type f -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg"))
  local random_index=$((RANDOM % ${#image_files[@]}))
  local random_image="${image_files[$random_index]}"

  if pidof swaybg > /dev/null; then
    killall swaybg
  fi

  echo ${random_image} > $HOME/.config/wallpaperpath

  swaybg -m fill -i ${random_image}

  exit 0
}

if [ $1 == "random" ]; then
  random_wallpaper
elif [ $1 == "init" ]; then
  set_wallpaper
else
  if pidof wofi >/dev/null; then
    killall wofi
    exit 0
  else
    main
  fi
fi

