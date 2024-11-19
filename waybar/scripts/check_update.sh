#!/bin/bash

COUNT=`pacman -Qu | wc -l`

if [[ "$COUNT" == "0" ]]
then
  echo ""
else
  echo " $COUNT"
fi
