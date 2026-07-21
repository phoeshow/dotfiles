-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
-- hl.on("hyprland.start", function ()
--   hl.exec_cmd(terminal)
--   hl.exec_cmd("nm-applet")
--   hl.exec_cmd("waybar & hyprpaper & firefox")
-- end)

hl.on("hyprland.start", function()
	-- polkit authentication daemon
	hl.exec_cmd("systemctl --user start hyprpolkitagent")

	hl.exec_cmd("hypridle")

	hl.exec_cmd("mako")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("blueman-applet")

	-- waybar
	hl.exec_cmd(
		"waybar --bar main-bar --log-level error --config ~/.config/waybar/hyprland.jsonc --style ~/.config/waybar/hyprland.css"
	)

	--wallpaper
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("~/.config/rofi/wallpaper/wallpaper.sh init")

	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("cliphist wipe")

	hl.exec_cmd("fcitx5 -d --replace")
	hl.exec_cmd("solaar --window=hide --battery-icons=regular")

	hl.exec_cmd("udiskie --smart-tray")
	hl.exec_cmd("clash-verge")
end)
