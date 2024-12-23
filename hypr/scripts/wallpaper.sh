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

  hyprctl hyprpaper preload "${wallpaperpath}"
  hyprctl hyprpaper wallpaper ",${wallpaperpath}"

  exit 0
}

# random_wallpaper() {
#   local target_directory="$HOME/Pictures/wallpapers"
#   local image_files=($(find "$target_directory" -type f -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg"))
#   local random_index=$((RANDOM % ${#image_files[@]}))
#   local random_image="${image_files[$random_index]}"
#
#
#   echo ${random_image} > $HOME/.config/wallpaperpath
#
#   set_wallpaper
#
# }

if [ $1 == "init" ]; then
  set_wallpaper
else
  main
fi

