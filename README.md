# Config

## Brightness

调整屏幕亮度，需要安装`wl-gammarelay-rs`包，并且在启动时运行。
按键的绑定如下：

```conf
bindl = , XF86MonBrightnessUp, exec, busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateBrightness d +0.02
bindl = , XF86MonBrightnessDown, exec, busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateBrightness d -0.02
```

## keyd config

1. linux 中通过keyd设置了按键映射，效果是将`capslock`键重新映射，按键一次`esc`，长按并同时输入`hjkl`输入方向键。

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

2. Mac 中通过其他映射软件可以实现相同的效果。

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
