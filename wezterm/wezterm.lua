local wezterm = require("wezterm")

-- This will hold the configuration.
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

local function platform()
  if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    return "Windows"
  elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
    return "Linux"
  elseif wezterm.target_triple == "x86_64-apple-darwin" or wezterm.target_triple == "aarch64-apple-darwin" then
    return "MacOS"
  else
    return "Unknown"
  end
end

if platform() == "Linux" then
  config.font_size = 12
else
  config.font_size = 16
end

config.color_scheme = "Catppuccin Frappe"
config.font = wezterm.font_with_fallback({
  "Rec Mono Semicasual",
  "Noto Sans Mono CJK SC",
})
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

local function is_inside_vim(pane)
  local tty = pane:get_tty_name()

  if tty == nil then
    return false
  end

  local success, stdout, stderr = wezterm.run_child_process({
    "sh",
    "-c",
    "ps -o state= -o comm= -t"
      .. wezterm.shell_quote_arg(tty)
      .. " | "
      .. "grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$'",
  })
  return success
end

local function is_outside_vim(pane)
  return not is_inside_vim(pane)
end

local function bind_if(cond, key, mods, action)
  local function callback(win, pane)
    if cond(pane) then
      win:perform_action(action, pane)
    else
      win:perform_action(act.SendKey({ key = key, mods = mods }), pane)
    end
  end

  return { key = key, mods = mods, action = wezterm.action_callback(callback) }
end

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
  bind_if(is_outside_vim, "h", "ALT", act.ActivatePaneDirection("Left")),
  bind_if(is_outside_vim, "l", "ALT", act.ActivatePaneDirection("Right")),
  bind_if(is_outside_vim, "j", "ALT", act.ActivatePaneDirection("Down")),
  bind_if(is_outside_vim, "k", "ALT", act.ActivatePaneDirection("Up")),
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

  local cwd = pane:get_current_working_dir()
  local cwd_path = cwd.file_path

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
    { Foreground = { Color = "#ea999c" } },
    { Attribute = { Intensity = "Bold" } },
    { Text = wezterm.nerdfonts.fa_folder_o .. " " .. basename(cwd_path) },
    "ResetAttributes",
    { Text = " | " },
    "ResetAttributes",
    { Foreground = { Color = "#e5c890" } },
    { Attribute = { Intensity = "Bold" } },
    { Text = wezterm.nerdfonts.fa_code .. " " .. basename(pane:get_foreground_process_name()) },
    "ResetAttributes",
    { Text = " | " },
    "ResetAttributes",
    { Attribute = { Intensity = "Bold" } },
    { Foreground = { Color = "#81c8be" } },
    { Text = wezterm.nerdfonts.fa_clock_o .. " " .. time },
  }))
end)

return config
