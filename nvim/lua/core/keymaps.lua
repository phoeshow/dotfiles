-- leader键
vim.g.mapleader = " " -- 空格键
-- Vim预置有很多快捷键，再加上各类插件的快捷键，大量快捷键出现在单层空间中难免引起冲突。
-- 为缓解该问题，而引入了前缀键<leader>。藉由前缀键， 则可以衍生出更多的快捷键命名空间（namespace)。

local map = vim.keymap.set

local opt = { noremap = true, silent = true } -- 不会递归映射，不在命令行上回显

-- 取消掉F1 打开帮助的快捷键，这键盘老是按到
-- 不过现在都映射到capslock键上了，误按的机会少很多了
map({ "n", "v", "i" }, "<F1>", "", opt)

-- 删除键不复制
map("n", "x", '"_x', opt)
-- visual 模式下p粘贴不覆写register
map("v", "p", '"_dP')

-- 数值增加 数值减少
map("n", "+", "<C-a>", opt)
map("n", "-", "<C-x>", opt)

-- 选中全部内容 ctrl+a
map("n", "<C-a>", "gg<S-v>G", opt)

-- 分屏跳转
-- Alt + hjkl  窗口之间跳转
-- map("n", "<A-h>", "<C-w>h", opt)
-- map("n", "<A-j>", "<C-w>j", opt)
-- map("n", "<A-k>", "<C-w>k", opt)
-- map("n", "<A-l>", "<C-w>l", opt)
-- Ctrl + 方向键 调整窗口大小
map("n", "<C-right>", "<C-w>>", opt)
map("n", "<C-left>", "<C-w><", opt)
map("n", "<C-up>", "<C-w>+", opt)
map("n", "<C-down>", "<C-w>-", opt)

-- buffer 切换
map("n", "<C-h>", ":bprevious<cr>", opt)
map("n", "<C-l>", ":bnext<cr>", opt)
-- use mini.bufremove instead
-- map("n", "<C-w>", ":bdelete!<cr>", opt) -- close tab

-- 可视模式下，shift+j shift+k 可以交换行内容，快速上下移动。
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 快速移动光标，一次5行，这个功能很好用，不过我现在适应了c-d/c-u 还有‘{‘|’}’找空行的方法，
-- 而且因为visual-multi插件占用了c-up和从-down快捷键，所以我重新映射了下面这两个快捷键给visual-multi的默认功能
-- map("n", "<C-j>", "5j", opt)
-- map("n", "<C-k>", "5k", opt)

-- 快速保存文件
map({ "n", "i" }, "<c-s>", "<cmd>w!<cr>", opt)

-- 取消高亮
map("n", "<leader>nh", ":nohl<CR>", opt)

-- file explore
-- map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", opt)
