-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("core")
-- plugins manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "nvim-tree/nvim-web-devicons", lazy = true },
  -- theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("plugins.theme")
    end,
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("plugins.noice")
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("plugins.notify")
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("plugins.surround")
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.comment")
    end,
  },
  { "nvim-tree/nvim-tree.lua",     dependencies = { "nvim-tree/nvim-web-devicons" } },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.lualine")
    end,
  },
  -- markdown previewer
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin" },
    event = { "BufNewFile", "BufRead", "TabEnter" },
    config = function()
      require("plugins.bufferline")
    end,
  },
  { "nvim-treesitter/nvim-treesitter",         build = ":TSUpdate" },
  { "nvim-treesitter/nvim-treesitter-refactor" },
  -- color highlight
  {
    "norcalli/nvim-colorizer.lua",
    event = "CursorHold",
    config = function()
      require("plugins.colorizer")
    end,
  },
  { "lukas-reineke/indent-blankline.nvim" },
  { "lewis6991/gitsigns.nvim",            opts = {} },
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "neovim/nvim-lspconfig",  -- Collection of configurations for built-in LSP client
  "williamboman/mason.nvim", -- Automatically install LSPs to stdpath for neovim
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
  },                  -- ibid
  "folke/neodev.nvim", -- Lua language server configuration for nvim
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("lsp.null-ls")
    end,
  },

  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
    },
  },
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",
  { "mg979/vim-visual-multi" },
  "akinsho/toggleterm.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.lsp_signature")
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("plugins.symbols-outline")
    end,
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap = require("dapconfig")
      dap.setupDap()
      dap.setupDapUI()
      -- dap.setupDebuggers()
    end,
  },
  -- {
  --   "microsoft/vscode-js-debug",
  --   opt = true,
  --   build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  -- },
})

require("plugins.nvim-tree")
require("plugins.treesitter")
require("plugins.indent-blankline")
require("plugins.telescope")

require("neodev").setup({})
require("plugins.autopairs")
require("lsp")
require("lsp.cmp")

require("plugins.toggleterm")
require("custom.lazygit")
