#!/bin/bash


if [[ ! $(pidof wofi) ]]; then
  wofi --show drun --prompt 'Search...' --insensitive
else
  pkill wofi
fi
