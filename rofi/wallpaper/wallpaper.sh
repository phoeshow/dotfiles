#!/usr/bin/bash

CONFIG_PATH="$HOME/.config/rofi/wallpaper/theme.rasi"
WALLPAPER_BASE_DIR="$HOME/Pictures/wallpapers"

main ()
{
  choice=$(ls ${WALLPAPER_BASE_DIR} | while read A ; do echo -en "$A\x00icon\x1f~/Pictures/wallpapers/$A\n" ; done | rofi -dmenu -mesg "Select wallpaper" -theme ${CONFIG_PATH})
  if [[ -z ${choice} ]]; then
    return
  fi
  real_path="${WALLPAPER_BASE_DIR}/${choice}"
  echo ${real_path} > $HOME/.config/wallpaperpath

  set_wallpaper

  exit
}


set_wallpaper() {
  local wallpaperpath

  if [[ -f "$HOME/.config/wallpaperpath" ]]; then
    wallpaperpath=$(<$HOME/.config/wallpaperpath)
  else
    wallpaperpath="$HOME/Pictures/wallpapers/default.png"
    echo ${wallpaperpath} > $HOME/.config/wallpaperpath
  fi

  # pkill swaybg
  # swaybg --image ${wallpaperpath} -m fill
  swww img ${wallpaperpath} --transition-type any --transition-duration 1 --transition-step 90 --transition-fps 60 
}

if [[ $1 == "init" ]]; then
  set_wallpaper
else
  main
fi
