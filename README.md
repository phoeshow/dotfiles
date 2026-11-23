# Config

## keyd 按键映射

1. 安装keyd
2. 编辑`/etc/keyd/default.conf`文件，增加如下内容

```conf
[ids]

*

[main]

capslock = overload(direction, esc)

[direction]
h = left
j = down
k = up
l = right
```

3. 通过systemd启动

```bash
sudo systemctl enable --now keyd
```

4. 重启服务
   `sudo keyd reload`

## Nuphy air75 keyboard

在Archlinux中通过如下设置，使Nuphy air75键盘的F区正常工作。

```bash
echo 'options hid_apple fnmode=0' | \
    sudo tee -a /etc/modprobe.d/hid_apple.conf
```

## Linux 下清理剪贴板

我在 Hyprland 中使用`cliphist`管理剪贴,但是不带自动清理的功能，可以定期执行

```bash
cliphist wipe
```

## scripts

功能性脚本放在仓库的 `scripts/` 目录，并软链接到 `~/.config/scripts`：

```bash
ln -sfn ~/dotfiles/scripts ~/.config/scripts
```

### media.sh

统一控制音量/麦克风/亮度，并通过 mako 弹出 OSD（含百分比进度条）：

```bash
~/.config/scripts/media.sh volume-up [step]
~/.config/scripts/media.sh volume-down [step]
~/.config/scripts/media.sh volume-set 60
~/.config/scripts/media.sh mute
~/.config/scripts/media.sh mic-mute
~/.config/scripts/media.sh brightness-up [step]   # 需要 brightnessctl
~/.config/scripts/media.sh brightness-down [step]
```

可用环境变量：`STEP=5`（默认步进）、`NOTIFY=0`（关闭通知，仅打印）、`OSD_TIMEOUT=1500`（OSD 停留毫秒）。

实现要点：同一 `x-canonical-private-synchronous` hint 让 mako 就地更新同一条通知（ID 不变），连续按键时 OSD 不会消失再出现。
