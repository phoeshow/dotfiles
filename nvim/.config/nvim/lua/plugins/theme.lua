require("catppuccin").setup({
  flavour = "frappe",        -- latte, frappe, macchiato, mocha
  show_end_of_buffer = false, -- show the '~' characters after the end of buffers
  transparent_background = true,
  -- term_colors = true,
  dim_inactive = {
    enabled = true,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = false, -- Force no italic
  no_bold = false,  -- Force no bold
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {},
  custom_highlights = function(colors)
    return {
      ["@tag"] = { fg = colors.teal },
      ["CursorLine"] = { bg = colors.surface0 },
    }
  end,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    telescope = true,
    notify = false,
    treesitter = true,
    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
  },
})
--
-- -- setup must be called before loading
vim.cmd.colorscheme("catppuccin-frappe")
--
-- require('kanagawa').setup({
--   transparent = true,
--   dimInactive = true,
--   terminalColors = true,
-- })
--
-- vim.cmd.colorscheme 'kanagawa-wave'
--[[ require("tokyonight").setup({
  style = "storm",
  transparent = false,
  lualine_blod = true,
}) ]]
-- vim.cmd([[colorscheme tokyonight-storm]])
