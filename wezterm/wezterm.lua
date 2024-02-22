local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Frappe"
config.font_size = 16
config.font = wezterm.font("Rec Mono Semicasual")
config.window_background_opacity = 0.9
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "RESIZE"

config.window_padding = {
  top = 0,
  bottom = 0,
}

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_left_half_circle_thick

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_right_half_circle_thick

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local edge_background = "#303446"
  local background = "#414559"
  local foreground = "#c6d0f5"
  local intensity = "Normal"

  if tab.is_active then
    background = "#a6d189"
    foreground = "#303446"
    intensity = "Bold"
  elseif hover then
    background = "#51576d"
    foreground = "#c6d0f5"
    intensity = "Normal"
  end

  local edge_foreground = background

  local title = tab_title(tab)

  -- ensure that the titles fit in the available space,
  -- and that we have room for the edges.
  title = wezterm.truncate_right(title, max_width - 2)

  return {
    { Attribute = { Intensity = intensity } },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = "█" },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = "█" },
  }
end)

local act = wezterm.action

config.keys = {
  {
    key = "t",
    mods = "CTRL",
    action = act.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "m",
    mods = "CMD",
    action = act.DisableDefaultAssignment,
  },
  {
    key = "t",
    mods = "CMD",
    action = act.DisableDefaultAssignment,
  },
  {
    key = "w",
    mods = "CMD",
    action = act.DisableDefaultAssignment,
  },
}

return config
