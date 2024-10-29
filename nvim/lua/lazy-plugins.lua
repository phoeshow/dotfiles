local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  require 'plugins/dashboard',
  require 'plugins/catppuccin',
  require 'plugins/neo-tree',
  require 'plugins/treesitter',
  require 'plugins/telescope',
  require 'plugins/mini',
  require 'plugins/flash',
  require 'plugins/lsp',
  require 'plugins/cmp',
  require 'plugins/conform',
  require 'plugins/autopairs',
  require 'plugins/autotag',
  require 'plugins/lualine',
  require 'plugins/gitsigns',
  require 'plugins/whichkey',
  require 'plugins/trouble',
  require 'plugins/lint',
  require 'plugins/debug',
  require 'plugins/indent-blankline',
  require 'plugins/navigator',
}, {
  ui = {
    border = 'single',
  },
})
