return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'frappe',
      transparent_background = true,
      integrations = {
        mini = {
          enabled = true,
          indentscope_color = 'peach',
        },
        indent_blankline = {
          enabled = true,
        },
        fidget = true,
      },
      custom_highlights = function(colors)
        return {
          IblIndent = { fg = colors.surface2 },
          LineNr = { fg = colors.surface1 },
          NeoTreeMessage = { fg = colors.surface1 },
        }
      end,
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
