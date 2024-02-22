return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require("which-key")
    wk.register({
      ["<leader>"] = {
        g = {
          name = "Git",
          o = { "<cmd>DiffviewOpen<cr>", "Conflict" },
          c = { "<cmd>DiffviewClose<cr>", "Close Diffview" },
          d = { "<cmd>DiffviewFileHistory %<cr>", "FileHistory" },
        },
        f = {
          name = "Find",
          f = { "<cmd>Telescope find_files<cr>", "Find File" },
          g = { "<cmd>Telescope live_grep<cr>", "Find Global" },
          b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
        },
        s = {
          name = "Split Pane",
          h = { "<cmd>sp<cr>", "Horizontal Split Pane" },
          v = { "<cmd>vsp<cr>", "Vertical Split Pane" },
          c = { "<C-w>c", "Close Pane" },
        },
        l = {
          name = "Lsp",
          r = { "<cmd>Lspsaga rename<cr>", "Rename" },
          a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
          -- o = { "<cmd>Lspsaga outline<cr>", "Document Symbols" },
        },
      },
    })
  end,
}
