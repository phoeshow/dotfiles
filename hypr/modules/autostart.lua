-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
  hl.exec_cmd("systemctl --user start hyprpolkitagent")

  -- notification daemon
  hl.exec_cmd("mako")

  -- status bar
  hl.exec_cmd("waybar")

  -- wallpaper
  hl.exec_cmd("hyprpaper")

  -- clipboard
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  hl.exec_cmd("cliphist wipe")

  -- idle
  hl.exec_cmd("hypridle")

  hl.exec_cmd("udiskie --smart-tray")
  hl.exec_cmd("fcitx5 -d --replace")
  hl.exec_cmd("clash-verge")
end)
