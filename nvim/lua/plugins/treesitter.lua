return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = {
        "lua",
        "html",
        "javascript",
        "typescript",
        "tsx",
        "vue",
        "markdown",
        "markdown_inline",
        "css",
        "yaml",
        "bash",
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- select in function
            ["if"] = {
              query = "@function.inner",
              desc = "Select inner of a function",
            },
            ["af"] = {
              query = "@function.outer",
              desc = "Select outer of a function",
            },
            -- select in function parameter
            ["ia"] = {
              query = "@parameter.inner",
              desc = "Select inner of a parameter",
            },
            ["aa"] = {
              query = "@parameter.outer",
              desc = "Select outer of a parameter",
            },
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]a"] = "@parameter.inner",
            ["]c"] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[a"] = "@parameter.inner",
            ["[c"] = "@class.outer",
          },
        },
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      auto_install = true,
      autotag = {
        enable = true,
      },
    })
  end,
}
