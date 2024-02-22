return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.3",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  lazy = false,
  config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    })
    require("telescope").load_extension("fzf")

    -- https://github.com/nvim-telescope/telescope.nvim/issues/699
    -- 这可是个老bug了，通过telescope打开的文件没法折叠代码
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      pattern = { "*" },
      command = "normal zx",
    })
  end,
}
