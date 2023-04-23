vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('core')
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
require('lazy').setup({
  -- { "catppuccin/nvim",                    name = "catppuccin" },
  -- 'rebelot/kanagawa.nvim',
  'folke/tokyonight.nvim',
  'numToStr/Comment.nvim',
  { 'nvim-tree/nvim-web-devicons',  lazy = true },
  { 'nvim-tree/nvim-tree.lua',      dependencies = { 'nvim-tree/nvim-web-devicons' } },
  { 'nvim-lualine/lualine.nvim',    dependencies = { 'nvim-tree/nvim-web-devicons' } },
  -- markdown previewer
  { 'iamcco/markdown-preview.nvim', build = function() vim.fn["mkdp#util#install"]() end },
  {
    'akinsho/bufferline.nvim',
    version = "v3.*",
    dependencies = 'nvim-tree/nvim-web-devicons'
  },
  { 'nvim-treesitter/nvim-treesitter',    build = ':TSUpdate' },
  -- color highlight
  { 'norcalli/nvim-colorizer.lua',        opts = {} },
  { "lukas-reineke/indent-blankline.nvim" },
  { 'lewis6991/gitsigns.nvim',            opts = {} },
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim' }
  },
  'neovim/nvim-lspconfig',   -- Collection of configurations for built-in LSP client
  'williamboman/mason.nvim', -- Automatically install LSPs to stdpath for neovim
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'neovim/nvim-lspconfig',
      'williamboman/mason.nvim' }
  },                   -- ibid
  'folke/neodev.nvim', -- Lua language server configuration for nvim
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind.nvim',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline'
    },
  },
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",

  "akinsho/toggleterm.nvim"
})

require('plugins.theme')
require('plugins.comment')
require('plugins.nvim-tree')
require('plugins.lualine')
require('plugins.treesitter')
require('plugins.indent-blankline')
require('plugins.telescope')
require('plugins.bufferline')


require('neodev').setup {}
require('plugins.autopairs')
require('lsp')
require('lsp.cmp')

require('plugins.toggleterm')
require('custom.lazygit')
