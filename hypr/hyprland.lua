------------------
---- MONITORS ----
------------------
require("modules.monitors")

-------------------
---- AUTOSTART ----
-------------------
require("modules.autostart")

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
require("modules.environment")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-----------------------
---- LOOK AND FEEL ----
-----------------------
require("modules.appearance")

----------------
----  OTHER ----
----------------

hl.config({
	misc = {
		disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
	},
})

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})
---------------------
---- KEYBINDINGS ----
---------------------
require("modules.keybindings")

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
require("modules.rules")
