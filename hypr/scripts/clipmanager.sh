#!/bin/sh


if [[ ! $(pidof wofi) ]]; then
  cliphist list | wofi --show dmenu --prompt 'Search...' \
    --width=600 --height=400 | cliphist decode | wl-copy
else
	pkill wofi
fi
