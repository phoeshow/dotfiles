-- 定义空格键为<leader>
vim.g.mapleader = " "
-- Vim预置有很多快捷键，再加上各类插件的快捷键，大量快捷键出现在单层空间中难免引起冲突。
-- 为缓解该问题，而引入了前缀键<leader>。藉由前缀键， 则可以衍生出更多的快捷键命名空间（namespace)。

local map = vim.api.nvim_set_keymap

local opt = { noremap = true, silent = true }

-- 删除键不复制
map('n', 'x', '"_x', opt)
-- +/-
map('n', '+', '<C-a>', opt)
map('n', '-', '<C-x>', opt)
-- select all
map('n', '<C-a>', 'gg<S-v>G', opt)

-- 窗口分屏
map('n', 's', '', opt)          -- 取消掉默认的s键功能
map("n", "sv", ":vsp<CR>", opt) -- 垂直分屏
map("n", "sh", ":sp<CR>", opt)  -- 水平分屏
map("n", "sc", "<C-w>c", opt)   -- 关闭当前分屏
-- buffer 切换
map("n", "<C-H>", ":bprevious<CR>", opt)
map("n", "<C-L>", ":bnext<CR>", opt)
-- buffer close
map("n", "<C-w>", ":bdelete<CR>", opt)

-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)
-- Alt + 方向键 调整窗口大小
map('n', '<A-right>', '<C-w>>', opt)
map('n', '<A-left>', '<C-w><', opt)
map('n', '<A-up>', '<C-w>+', opt)
map('n', '<A-down>', '<C-w>-', opt)
-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+2<CR>gv-gv", opt)
map("v", "K", ":move '<-1<CR>gv-gv", opt)
-- 上下滚动浏览
map("n", "<C-j>", "5j", opt)
map("n", "<C-k>", "5k", opt)

-- nvim-tree
-- 空格+e 键打开关闭tree
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)

-- Telescope
map("n", "<leader>t", ":Telescope buffers<CR>", opt)
-- 查找文件
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- 全局搜索
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)

-- 取消高亮
map("n", "<leader>nh", ":nohl<CR>", opt)
-- comment
-- vim.keymap.set("n", "<C-_>", require("Comment.api").toggle.linewise.current, opt)
-- vim.keymap.set("v", "<C-_>", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", opt)
