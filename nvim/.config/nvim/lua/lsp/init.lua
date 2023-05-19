require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

require("mason-lspconfig").setup({ automatic_installation = true })

local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  -- 禁用格式化功能，交给专门插件插件处理
  -- client.resolved_capabilities.document_formatting = false
  -- client.resolved_capabilities.document_range_formatting = false

  local attach_opts = { silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, attach_opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, attach_opts)
  vim.keymap.set("n", "<leader>gd", "svgd", attach_opts)
  vim.keymap.set("n", "gh", vim.lsp.buf.hover, attach_opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, attach_opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, attach_opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, attach_opts)
  vim.keymap.set("n", "so", require("telescope.builtin").lsp_references, attach_opts)
  -- diagnostic
  vim.keymap.set("n", "gp", vim.diagnostic.open_float, attach_opts)
  vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, attach_opts)
  vim.keymap.set("n", "g]", vim.diagnostic.goto_next, attach_opts)

  vim.keymap.set({ "n" }, "<Leader>k", function()
    vim.lsp.buf.signature_help()
  end, { silent = true, noremap = true, desc = "toggle signature" })

  require("lsp_signature").on_attach({
    bind = true,
    handler_opts = {
      border = "single",
    },
    hint_enable = false,
    noice = true,
    toggle_key = "<C-k>",
  }, bufnr)
end
require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = { Lua = { diagnostics = { globals = { "vim" } } } },
    })
  end,
})
