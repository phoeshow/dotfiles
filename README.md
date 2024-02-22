# Config

## keyd config

1. linux 中通过keyd设置了按键映射，效果是将`capslock`键重新映射，按键一次`esc`，长按并同时输入`hjkl`输入方向键。

```
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

```
echo 'options hid_apple fnmode=0' | \
    sudo tee -a /etc/modprobe.d/hid_apple.conf
```
