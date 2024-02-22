return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("ibl").setup({
        indent = {
          char = "▎",
        },
        scope = {
          enabled = false,
          char = "▎",
          show_start = true,
          show_end = true,
        },
        exclude = {
          filetypes = {
            "dashboard",
            "lspinfo",
            "mason",
            "checkhealth",
          },
        },
      })
    end,
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mini.indentscope").setup({
        options = {
          border = "both",
          try_as_border = true,
        },
        symbol = "▎",
      })
      -- Disable for certain filetypes
      vim.api.nvim_create_autocmd({ "FileType" }, {
        desc = "Disable indentscope for certain filetypes",
        pattern = {
          "dashboard",
          "help",
          "lspinfo",
          "lazy",
          "mason",
          "neo-tree",
          "neogitstatus",
          "notify",
          "toggleterm",
          "Trouble",
          "checkhealth",
          "lspsaga",
          "NvimTree",
          "Outline",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
