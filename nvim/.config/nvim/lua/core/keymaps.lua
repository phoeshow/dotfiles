-- 定义空格键为<leader>
vim.g.mapleader = " "
-- Vim预置有很多快捷键，再加上各类插件的快捷键，大量快捷键出现在单层空间中难免引起冲突。
-- 为缓解该问题，而引入了前缀键<leader>。藉由前缀键， 则可以衍生出更多的快捷键命名空间（namespace)。

local map = vim.api.nvim_set_keymap

local opt = { noremap = true, silent = true }

-- 窗口分屏
map("n", "sv", ":vsp<CR>", opt) --垂直分屏
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
-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)
-- 上下滚动浏览
map("n", "<C-j>", "4j", opt)
map("n", "<C-k>", "4k", opt)

-- nvim-tree
-- 空格+e 键打开关闭tree
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)


-- Telescope
-- 查找文件
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- 全局搜索
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)

-- 取消高亮
map("n", "<leader>nh", ":nohl<CR>", opt)
