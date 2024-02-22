return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
        transparent_background = true,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = { "italic" },

          keywords = { "bold" },
        },
        integrations = {
          nvimtree = true,
          neotree = true,
          dashboard = true,
          which_key = true,
          noice = true,
          notify = true,
          mason = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = false,
            scope_color = "peach",
          },
          illuminate = true,
          gitsigns = true,
          cmp = true,
          lsp_saga = true,
          mini = {
            enabled = true,
            indentscope_color = "peach",
          },
          flash = true,
          telescope = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
        },
        custom_highlights = function(colors)
          return {
            LineNr = { fg = colors.surface2 },
          }
        end,
        highlight_overrides = {
          frappe = function(colors)
            return {
              IblIndent = { fg = colors.surface2 },
              NeoTreeMessage = { fg = colors.surface1 },
              GitSignsChange = { fg = colors.peach },
            }
          end,
        },
      })

      vim.cmd.colorscheme("catppuccin")
    end,
  },
  -- {
  --   "neanias/everforest-nvim",
  --   enabled = false,
  --   version = false,
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.o.background = "dark"
  --     require("everforest").setup({
  --       transparent_background_level = 1,
  --       ui_contrast = "high",
  --       italics = true,
  --     })
  --     vim.cmd.colorscheme("everforest")
  --   end,
  -- },
}
