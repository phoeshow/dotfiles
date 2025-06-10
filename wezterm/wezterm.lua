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

local colors = {
  rosewater = "#f5e0dc",
  flamingo = "#f2cdcd",
  pink = "#f5c2e7",
  mauve = "#cba6f7",
  red = "#f38ba8",
  maroon = "#eba0ac",
  peach = "#fab387",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#74c7ec",
  blue = "#89b4fa",
  lavender = "#b4befe",
  text = "#cdd6f4",
  subtext1 = "#bac2de",
  subetxt0 = "#a6adc8",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay0 = "#6c7086",
  surface2 = "#585b70",
  surface1 = "#45475a",
  surface0 = "#313244",
  base = "#1e1e2e",
  mantle = "#181825",
  crust = "#11111b",
}

config.font_size = 16

local custom_scheme = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]

custom_scheme.tab_bar.background = colors.surface0

config.color_schemes = {
  ["OLEDppuccin"] = custom_scheme,
}

config.color_scheme = "OLEDppuccin"
config.font = wezterm.font_with_fallback({
  {
    family = "Maple Mono CN",
    weight = "Regular",
  },
})
config.window_background_opacity = 0.9
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.window_decorations = "RESIZE"
config.status_update_interval = 1000
config.window_close_confirmation = "AlwaysPrompt"
config.disable_default_key_bindings = true
config.adjust_window_size_when_changing_font_size = false
-- wait fix on wayland
config.enable_wayland = true

if platform() == "Linux" then
  config.window_decorations = "NONE"
  config.font_size = 11
end

if platform() == "MacOS" then
  config.window_decorations = "RESIZE|MACOS_FORCE_ENABLE_SHADOW"
end

config.window_padding = {
  top = 0,
  bottom = 0,
}

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.7,
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
  key = "b",
  mods = "CTRL",
  timeout_milliseconds = 1000,
}

config.keys = {
  { key = "b", mods = "LEADER|CTRL", action = act.SendKey({ key = "b", mods = "CTRL" }) },
  { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  bind_if(is_outside_vim, "h", "CTRL", act.ActivatePaneDirection("Left")),
  bind_if(is_outside_vim, "l", "CTRL", act.ActivatePaneDirection("Right")),
  bind_if(is_outside_vim, "j", "CTRL", act.ActivatePaneDirection("Down")),
  bind_if(is_outside_vim, "k", "CTRL", act.ActivatePaneDirection("Up")),
  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
  { key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
  { key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
  -- paste from clipboard
  { key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },
  -- copy from selection
  { key = "C", mods = "CTRL", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },

  -- copy-mode
  { key = "C", mods = "LEADER", action = act.ActivateCopyMode },

  -- change font size
  { key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
  { key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
  { key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },

  -- Prompt for a name to use for a new workspace and wsitch to it
  {
    key = "W",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Enter name for new workspace" },
      }),
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            act.SwitchToWorkspace({
              name = line,
            }),
            pane
          )
        end
      end),
    }),
  },
  {
    key = "S",
    mods = "LEADER",
    action = act.ShowLauncherArgs({
      flags = "FUZZY|WORKSPACES",
    }),
  },

  -- CTRL-SHIFT-l activates the debug overlay
  { key = "L", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },
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
  local stat = window:active_workspace()
  local stat_color = colors.base
  local stat_back_color = colors.blue
  local stat_seprator = ""
  if window:active_key_table() then
    stat = window:active_key_table() .. " "
    stat_color = colors.base
    stat_back_color = colors.mauve
  end
  if window:leader_is_active() then
    stat_color = colors.base
    stat_back_color = colors.maroon
  end

  local basename = function(s)
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
  end

  local cwd = pane:get_current_working_dir()
  local cwd_path = cwd.file_path:match("([^/]+)/?$")

  -- local win_count = wezterm.nerdfonts.cod_window
  local win_split_state = ""
  local tab = pane:tab()
  if tab ~= nil then
    if #tab:panes_with_info() == 1 then -- single pane
      win_split_state = ""
    else
      win_split_state = "" -- split window
      for _, p in ipairs(tab:panes_with_info()) do
        if p.is_zoomed and p.is_active then -- zoomed window
          win_split_state = ""
        end
      end
    end
  end

  -- Left status (left of the tab line)
  window:set_left_status(wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Foreground = { Color = stat_color } },
    { Background = { Color = stat_back_color } },
    { Text = " " .. "󱩛 " .. stat },
    { Foreground = { Color = stat_back_color } },
    { Background = { Color = colors.surface0 } },
    { Text = stat_seprator },
  }))

  -- Right Status
  window:set_right_status(wezterm.format({
    { Foreground = { Color = colors.base } },
    { Background = { Color = colors.mauve } },
    { Attribute = { Intensity = "Bold" } },
    { Text = " " .. win_split_state .. "  " },
    "ResetAttributes",
    { Foreground = { Color = colors.base } },
    { Background = { Color = colors.red } },
    { Attribute = { Intensity = "Bold" } },
    { Text = " " .. "󰉋 " .. cwd_path .. " " },
    -- "ResetAttributes",
    -- { Background = { Color = colors.yellow } },
    -- { Foreground = { Color = colors.base } },
    -- { Attribute = { Intensity = "Bold" } },
    -- { Text = " " .. wezterm.nerdfonts.dev_terminal .. " " .. basename(pane:get_foreground_process_name()) .. " " },
    "ResetAttributes",
    { Attribute = { Intensity = "Bold" } },
    { Foreground = { Color = colors.base } },
    { Background = { Color = colors.teal } },
    { Text = " " .. "󰥔 " .. time .. " " },
  }))
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local background = colors.surface1
  local foreground = colors.overlay2

  if tab.is_active then
    background = colors.green
    foreground = colors.base
  elseif hover then
    background = colors.surface2
    foreground = colors.text
  end

  local edge_background = colors.surface0
  local edge_foreground = background
  local index = tab.tab_index
  local title = tab.active_pane.title

  return wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Background = { Color = edge_foreground } },
    { Foreground = { Color = edge_background } },
    { Text = "" },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = " " .. index + 1 .. "  " .. title .. " " },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = "" },
  })
end)

return config
