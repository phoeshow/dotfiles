#!/usr/bin/env bash
#
# media.sh - 统一的音量/麦克风/亮度控制，并通过 mako 弹出 OSD 提示
#
# 用法: media.sh <命令> [参数]
#   volume-up   [step]     音量 +step%（默认 5，上限 100%）
#   volume-down [step]     音量 -step%
#   volume-set  <percent>  设置音量百分比（0-100）
#   mute                   切换默认输出静音
#   mic-mute               切换默认输入静音
#   volume-status          仅显示当前音量
#   brightness-up   [step] 亮度 +step%（默认 5，需 brightnessctl）
#   brightness-down [step] 亮度 -step%
#   brightness-status      仅显示当前亮度
#   help                   显示本帮助
#
# 环境变量:
#   STEP=5        默认步进百分比
#   NOTIFY=1      设为 0 可禁用 mako 通知（只打印结果）
#
set -uo pipefail

STEP=${STEP:-5}
NOTIFY=${NOTIFY:-1}

SINK="@DEFAULT_AUDIO_SINK@"
SOURCE="@DEFAULT_AUDIO_SOURCE@"

APP_NAME="media"
# 同一条通知的复用标签：mako 识别 x-canonical-private-synchronous，
# 相同取值的通知会就地更新（同一 ID），不会先消失再出现，连续按键才连贯
REPLACE_TAG="media-osd"
# OSD 停留时间（毫秒），每次更新会重新计时
OSD_TIMEOUT=${OSD_TIMEOUT:-1500}

# ---------------------------------------------------------------- 通知

have() { command -v "$1" >/dev/null 2>&1; }

notify() { # <summary> <body> <icon> <progress 0-100|""> [urgency]
  local summary=$1 body=$2 icon=$3 progress=${4:-} urgency=${5:-low}

  if [[ $NOTIFY -ne 1 ]] || ! have notify-send; then
    printf '%s %s\n' "$summary" "${body:-(${progress}%)}"
    return 0
  fi

  local args=(
    --app-name="$APP_NAME"
    --icon="$icon"
    --urgency="$urgency"
    --transient
    --expire-time="$OSD_TIMEOUT"
    -h "string:x-canonical-private-synchronous:$REPLACE_TAG"
  )
  [[ -n $progress ]] && args+=(-h "int:value:$progress")

  # 不传 --replace-id：mako 靠上面的 hint 就地替换，无重绘闪烁
  notify-send "${args[@]}" "$summary" "$body" 2>/dev/null || true
}

# ---------------------------------------------------------------- 音量

sink_state() { # 输出 "百分比 是否静音"，只调用一次 wpctl
  local raw
  raw=$(wpctl get-volume "$SINK" 2>/dev/null) || return 1
  [[ -n $raw ]] || return 1
  awk '{ printf "%d %d\n", ($2 * 100) + 0.5, ($3 == "[MUTED]") }' <<<"$raw"
}

sink_icon() { # <muted:0|1> <percent>
  local muted=$1 pct=$2
  if [[ $muted -eq 1 ]] || [[ $pct -eq 0 ]]; then
    echo "audio-volume-muted"
  elif ((pct < 34)); then
    echo "audio-volume-low"
  elif ((pct < 67)); then
    echo "audio-volume-medium"
  else
    echo "audio-volume-high"
  fi
}

show_volume() {
  local pct muted icon summary
  read -r pct muted < <(sink_state) || {
    notify "音量" "未找到音频输出设备" "audio-volume-muted"
    return 1
  }
  [[ -n ${pct:-} ]] || {
    notify "音量" "未找到音频输出设备" "audio-volume-muted"
    return 1
  }
  icon=$(sink_icon "$muted" "$pct")
  if [[ $muted -eq 1 ]]; then
    summary="已静音"
  else
    summary="音量 ${pct}%"
  fi
  notify "$summary" "" "$icon" "$((muted ? 0 : pct))"
}

volume_step() { # <+|-> <step>
  local sign=$1 step=${2:-$STEP}
  wpctl set-volume -l 1.0 "$SINK" "${step}%${sign}" 2>/dev/null || {
    notify "音量" "设置音量失败" "audio-volume-muted"
    return 1
  }
  show_volume
}

volume_set() {
  local pct=${1:-}
  [[ $pct =~ ^[0-9]+$ ]] || {
    notify "音量" "无效的百分比: ${pct:-<空>}" "audio-volume-muted"
    return 1
  }
  ((pct > 100)) && pct=100
  wpctl set-volume "$SINK" "$((pct))%" 2>/dev/null || return 1
  show_volume
}

mute_toggle() {
  wpctl set-mute "$SINK" toggle 2>/dev/null || return 1
  show_volume
}

mic_mute_toggle() {
  local raw muted icon summary pct
  wpctl set-mute "$SOURCE" toggle 2>/dev/null || {
    notify "麦克风" "未找到输入设备" "microphone-sensitivity-muted"
    return 1
  }
  raw=$(wpctl get-volume "$SOURCE" 2>/dev/null)
  muted=0
  [[ $raw == *'[MUTED]'* ]] && muted=1
  pct=$(awk '{ printf "%d", ($2 * 100) + 0.5 }' <<<"$raw")
  if [[ $muted -eq 1 ]]; then
    icon="microphone-sensitivity-muted"
    summary="麦克风已静音"
  else
    icon="microphone-sensitivity-high"
    summary="麦克风已开启"
  fi
  notify "$summary" "" "$icon" "$pct"
}

# ---------------------------------------------------------------- 亮度

brightness_available() { have brightnessctl; }

brightness_pct() {
  local max cur
  max=$(brightnessctl --device='*' max 2>/dev/null) || return 1
  cur=$(brightnessctl get 2>/dev/null) || return 1
  awk -v c="$cur" -v m="$max" 'BEGIN { printf "%d", (c / m * 100) + 0.5 }'
}

show_brightness() {
  local pct
  pct=$(brightness_pct) || {
    notify "亮度" "未找到可调亮度设备" "display-brightness-symbolic"
    return 1
  }
  notify "亮度 ${pct}%" "" "display-brightness-symbolic" "$pct"
}

brightness_step() { # <+|-> <step>
  local sign=$1 step=${2:-$STEP}
  brightness_available || {
    notify "亮度" "未安装 brightnessctl" "display-brightness-symbolic"
    return 1
  }
  brightnessctl -e4 -n2 set "${step}%${sign}" 2>/dev/null || return 1
  show_brightness
}

# ---------------------------------------------------------------- 入口

usage() { sed -n '3,20p' "$0" | sed 's/^# \{0,1\}//'; }

case "${1:-}" in
volume-up) volume_step + "${2:-$STEP}" ;;
volume-down) volume_step - "${2:-$STEP}" ;;
volume-set) volume_set "${2:-}" ;;
mute) mute_toggle ;;
mic-mute) mic_mute_toggle ;;
volume-status | volume) show_volume ;;
brightness-up) brightness_step + "${2:-$STEP}" ;;
brightness-down) brightness_step - "${2:-$STEP}" ;;
brightness-status | brightness) show_brightness ;;
help | -h | --help) usage ;;
*)
  usage
  exit 1
  ;;
esac
