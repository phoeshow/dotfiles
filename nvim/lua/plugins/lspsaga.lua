return {
  "nvimdev/lspsaga.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- rename default key map
    -- exec = <cr> execute rename
    -- select = x, select or cancel select item in project_replace float window
    require("lspsaga").setup({
      ui = {
        border = "single",
        -- kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
      },
      symbol_in_winbar = {
        enable = false,
        hide_keyword = true,
        show_file = false,
      },
      rename = {
        keys = {
          quit = "q",
        },
      },
      outline = {
        enable = true,
        close_after_jump = true,
        layout = "float",
      },
      definition = {
        keys = {
          edit = "o",
          vsplit = "s",
        },
      },
      lightbulb = {
        sign = false,
      },
      diagnostic = {
        border_follow = false,
      },
    })
  end,
  event = "LspAttach",
}
