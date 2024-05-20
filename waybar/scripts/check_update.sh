#!/bin/bash

COUNT=`yay -Qu | wc -l`

if [[ "$COUNT" == "0" ]]
then
  echo ""
else
  echo " $COUNT"
fi

exit 0
