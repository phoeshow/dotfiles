local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Frappe"
config.font_size = 16
config.font = wezterm.font("Rec Mono Semicasual")
config.window_background_opacity = 0.9
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.window_decorations = "RESIZE"
config.status_update_interval = 1000
config.window_close_confirmation = "AlwaysPrompt"
config.disable_default_key_bindings = true
config.adjust_window_size_when_changing_font_size = false

config.window_padding = {
  top = 0,
  bottom = 0,
}

config.colors = {
  tab_bar = {
    active_tab = {
      bg_color = "#a6d189",
      fg_color = "#303446",
      intensity = "Bold",
    },
  },
}

local act = wezterm.action
config.leader = {
  key = "a",
  mods = "CTRL",
  timeout_milliseconds = 1000,
}

config.keys = {
  { key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
  { key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
  { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
  -- paste from clipboard
  { key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },
  -- copy from selection
  { key = "C", mods = "CTRL", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },

  -- copy-mode
  { key = "c", mods = "LEADER", action = act.ActivateCopyMode },

  -- change font size
  { key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
  { key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
  { key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },
}

-- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1),
  })
end

config.key_tables = {
  resize_pane = {
    { key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },

    { key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
    { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },

    { key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },

    { key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
    { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },

    -- Cancel the mode by pressing escape
    { key = "Escape", action = "PopKeyTable" },
  },
}

wezterm.on("update-status", function(window, pane)
  local time = wezterm.strftime("%H:%M")
  local stat = ""
  local stat_color = "#a6d189"
  if window:active_key_table() then
    stat = window:active_key_table() .. " "
    stat_color = "#ca9ee6"
  end
  if window:leader_is_active() then
    stat = "LDR "
    stat_color = "#ef9f76"
  end

  local basename = function(s)
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
  end

  -- Left status (left of the tab line)
  window:set_left_status(wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Foreground = { Color = stat_color } },
    { Text = "  " },
    { Text = wezterm.nerdfonts.md_leaf .. "  " .. stat },
  }))

  -- Right Status
  window:set_right_status(wezterm.format({
    { Foreground = { Color = "#e5c890" } },
    { Attribute = { Intensity = "Bold" } },
    { Text = basename(pane:get_foreground_process_name()) },
    "ResetAttributes",
    { Text = " | " },
    "ResetAttributes",
    { Attribute = { Intensity = "Bold" } },
    { Foreground = { Color = "#81c8be" } },
    { Text = wezterm.nerdfonts.md_clock .. " " .. time },
  }))
end)

return config
