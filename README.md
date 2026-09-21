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
