
#!/usr/bin/env bash

dir="$HOME/.config/rofi/recorder"

startRecord=''
stopRecord=''

rofi_cmd() {
  rofi -dmenu \
       -p "Record Screen" \
       -theme ${dir}/theme.rasi
}

run_rofi() {
  echo -e "$startRecord\n$stopRecord" | rofi_cmd
}

choice=$(run_rofi)

case ${choice} in
  $startRecord)
    gpu-screen-recorder -w screen -f 60 -a default_output -o $HOME/Videos/Video_$(date +"%Y-%m-%d_%H:%M:%S.mp4")
  ;;
  $stopRecord)
    pkill -SIGINT -f "^gpu-screen-recorder"
  ;;
esac

