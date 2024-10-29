-- 离开输入模式后关闭拼音输入法
vim.api.nvim_create_autocmd({ 'InsertLeave', 'CmdlineLeave' }, {
  group = vim.api.nvim_create_augroup('switch-im', { clear = true }),
  callback = function()
    if vim.fn.has 'linux' == 1 and vim.fn.executable 'fcitx5-remote' == 1 then
      vim.fn.system 'fcitx5-remote -c'
    elseif vim.fn.has 'mac' == 1 then
      vim.fn.system '/usr/local/bin/im-select com.apple.keylayout.ABC'
    end
  end,
})

-- highlight yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Disable for certain filetypes
vim.api.nvim_create_autocmd({ 'FileType' }, {
  desc = 'Disable indentscope for certain filetypes',
  pattern = {
    'dashboard',
    'help',
    'lspinfo',
    'lazy',
    'mason',
    'neo-tree',
    'neogitstatus',
    'notify',
    'toggleterm',
    'Trouble',
    'checkhealth',
    'lspsaga',
    'NvimTree',
    'Outline',
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

-- Disable scrolling for help buffers
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Disable scrolling for help buffers',
  pattern = 'help',
  callback = function()
    vim.b.cinnamon_disable = true
  end,
})
