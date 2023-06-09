local status, lualine = pcall(require, "lualine")

if not status then
  return
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "catppuccin",
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "█", right = "█" },
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = { { "filename", path = 1 } },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "nvim-tree", "toggleterm" },
})
