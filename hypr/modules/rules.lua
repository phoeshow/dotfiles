hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.window_rule({
	name = "net_manager",
	match = {
		class = "^(nm-connection-editor)$",
	},
	float = true,
	center = true,
})

hl.window_rule({
	name = "bluetooth",
	match = {
		class = "^(blueman-manager)$",
	},
	float = true,
	center = true,
})

hl.window_rule({
	name = "nwg-look",
	match = {
		class = "^(nwg-look)$",
	},
	float = true,
	center = true,
})

hl.window_rule({
	name = "kitty_noblur",
	match = {
		class = "^(kitty)$",
	},
	no_blur = true,
})

hl.window_rule({
	name = "ghostty_noblur",
	match = {
		class = "^(com.mitchellh.ghostty)$",
	},
	no_blur = true,
})

hl.window_rule({
	name = "steam",
	match = {
		class = "^(steam)$",
	},
	workspace = "7 silent",
})
hl.window_rule({
	name = "lutris",
	match = {
		class = "^(net.lutris.Lutris)$",
	},
	workspace = "7 silent",
})
hl.window_rule({
	name = "obs",
	match = {
		class = "^(com.obsproject.Studio)$",
	},
	workspace = "9",
})
hl.window_rule({
	name = "spotify",
	match = {
		class = "^(spotify)$",
	},
	workspace = "8",
})

hl.window_rule({
	name = "netease-music",
	match = {
		class = "^(com.gitee.gmg137.NeteaseCloudMusicGtk4)$",
	},
	workspace = "8",
})

hl.window_rule({
	name = "wow",
	match = {
		initial_title = "^(魔兽世界)$",
	},
	fullscreen = true,
	fullscreen_state = "2",
})
