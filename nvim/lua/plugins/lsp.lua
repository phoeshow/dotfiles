return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
    },
    event = "VeryLazy",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local on_attach = function(client, bufnr)
        -- LSP
        -- hover doc
        -- double 'gh' open jump into doc detail , 'gx' on link open brower
        vim.keymap.set(
          "n",
          "gh",
          "<cmd>Lspsaga hover_doc<cr>",
          { desc = "Open doc", buffer = bufnr }
        )
        -- open signature_help
        vim.keymap.set(
          "n",
          "gk",
          vim.lsp.buf.signature_help,
          { buffer = bufnr, desc = "Open Signature Help" }
        )
        -- 'gd' open lspsaga finder
        vim.keymap.set(
          "n",
          "gd",
          "<cmd>Lspsaga peek_definition<cr>",
          { desc = "Definition", buffer = bufnr }
        )
        vim.keymap.set(
          "n",
          "gD",
          "<cmd>Lspsaga finder<cr>",
          { desc = "Ref&Impl Finder", buffer = bufnr }
        )
        -- 'g[' and 'g]'
        -- jump diagnostic
        vim.keymap.set(
          "n",
          "g[",
          "<cmd>Lspsaga diagnostic_jump_prev<cr>",
          { desc = "prev diagnostic", buffer = bufnr }
        )
        vim.keymap.set(
          "n",
          "g]",
          "<cmd>Lspsaga diagnostic_jump_next<cr>",
          { desc = "next diagnostic", buffer = bufnr }
        )
      end
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
          border = "single",
        },
      })
      require("neodev").setup({})
      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({
              on_attach = on_attach,
              capabilities = capabilities,
            })
          end,

          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              on_attach = on_attach,
              capabilities = capabilities,
              settings = {
                Lua = {
                  completion = {
                    callSnippet = "Replace",
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },
}
