local map = vim.keymap.set

local opt = { noremap = true, silent = true } -- 不递归映射，不在命令行中回显

local keymap_desc = function(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- 剪切键'x'内容不进入寄存器
map('n', 'x', '"_x', opt)

-- visual 模式下p 粘贴不复写register
map('v', 'p', '"_dP')

-- '+/-' 数值增减
map('n', '+', '<C-a>', opt)
map('n', '-', '<C-x>', opt)

-- 分屏
map('n', '<leader>wh', '<cmd>split<cr>', { desc = '[W]indow split [H]orizontally' })
map('n', '<leader>wv', '<cmd>vsplit<cr>', { desc = '[W]indow split [V]ertical' })
map('n', '<leader>wd', '<C-w>c', { desc = '[Window] [D]elete' })
-- 分屏定位 ctrl+hjkl
-- map('n', '<C-h>', '<C-w><C-h>', opt)
-- map('n', '<C-j>', '<C-w><C-j>', opt)
-- map('n', '<C-k>', '<C-w><C-k>', opt)
-- map('n', '<C-l>', '<C-w><C-l>', opt)
map({ 'n', 't' }, '<C-h>', '<CMD>NavigatorLeft<CR>')
map({ 'n', 't' }, '<C-j>', '<CMD>NavigatorDown<CR>')
map({ 'n', 't' }, '<C-k>', '<CMD>NavigatorUp<CR>')
map({ 'n', 't' }, '<C-l>', '<CMD>NavigatorRight<CR>')

-- 分屏尺寸 Ctrl + 方向键
map('n', '<C-right>', '<C-w>>', keymap_desc 'Resize window right')
map('n', '<C-left>', '<C-w><', keymap_desc 'Resize window left')
map('n', '<C-up>', '<C-w>+', keymap_desc 'Resize window up')
map('n', '<C-down>', '<C-w>-', keymap_desc 'Resize window down')

-- buffer 切换
map('n', '<S-h>', '<cmd>bprevious<cr>', keymap_desc 'Previous buffer')
map('n', '<S-l>', '<cmd>bnext<cr>', keymap_desc 'Next buffer')
map('n', '<leader>bp', '<cmd>bprevious<cr>', { desc = '[B]uffer switch [P]revious' })
map('n', '<leader>bn', '<cmd>bnext<cr>', { desc = '[B]uffer switch [N]ext' })

-- 行交换 alt + j/k
map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move Down' })
map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move Up' })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Down' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Up' })

-- normal 模式下 esc 取消搜索高亮
map('n', '<Esc>', '<cmd>nohlsearch<cr>', opt)
