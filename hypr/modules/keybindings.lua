local terminal = "kitty"
-- local terminal = "ghostty +new-window"
local fileManager = "nautilus"

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind("SUPER + D", hl.dsp.exec_raw("~/.config/rofi/launcher/launcher.sh"))
hl.bind("SUPER + 0", hl.dsp.exec_raw("~/.config/rofi/powermenu/powermenu.sh"))
hl.bind("SUPER + M", hl.dsp.exec_raw("~/.config/rofi/audiomenu/audiomenu.sh"))
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("~/.config/rofi/recorder/recorder.sh"))
hl.bind(
	"SUPER + SHIFT + W",
	hl.dsp.exec_cmd(
		"killall waybar && waybar --bar main-bar --log-level error --config ~/.config/waybar/hyprland.jsonc --style ~/.config/waybar/hyprland.css"
	)
)

-- move focus with SUPER + HJKL
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
-- move focus with SUPER + Arrow
hl.bind("SUPER + LEFT", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + DOWN", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + UP", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + RIGHT", hl.dsp.focus({ direction = "right" }))
-- move window with SUPER + CTRL + HJKL
hl.bind("SUPER + CTRL + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + CTRL + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + CTRL + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + CTRL + L", hl.dsp.window.move({ direction = "right" }))
-- move window with SUPER + CTRL + Arrow
hl.bind("SUPER + CTRL + LEFT", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + CTRL + DOWN", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + CTRL + UP", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + CTRL + RIGHT", hl.dsp.window.move({ direction = "right" }))

-- Switch workspaces
for i = 1, 9 do
	hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + CTRL + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- media feature
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/media.sh --increase_vol"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/media.sh --decrease_vol"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/media.sh --toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/media.sh --toggle-mic"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
