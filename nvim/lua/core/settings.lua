local opt = vim.opt
-- local global = vim.g

-- for nvim-tree
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

opt.exrc = true
-- encoding
opt.encoding = "utf-8"

-- 如果是git切换分支的话 还是要用 :bufdo e 命令来更新
-- autoread 可以在其他编辑器改变了文件的情况下自动更新文件
vim.o.autoread = true
vim.bo.autoread = true

-- line number
opt.number = true -- 开启行号显示
opt.relativenumber = true -- 开启相对行号
opt.signcolumn = "yes" -- 开启标记列
opt.scrolloff = 8 -- 滚动边距 8行
opt.sidescrolloff = 5 -- 水平滚动边距 5列

-- search
opt.ignorecase = true -- 搜索忽略大小写
opt.smartcase = true -- 当输入内容包含大写时，自动停止忽略大小写

-- tab 键行为
--
-- tabstop 表示一个tab显示的宽度
-- softtabstop 编辑时键入tab所显示的宽度。如果设置的值和tabstop不相等，则会在其中加入空格对齐
-- 比如tabstop为8，softtabstop为4，按第一个tab时，插入4个空格，再按一次，变成一个tab。
-- 比如tabstop为4，softtabstop为6，按第一个tab时，变成一个tab+2个空格。再按一下，变成3个tab。
-- shiftwidth是调整格式时，比如使用<<和>>命令，缩进的宽度。
-- expandtab，是插入tab时，把tab变成空格。
--
opt.shiftwidth = 2 -- 缩进和自动缩进的步数为2字符
opt.smarttab = true -- 输入tab时，使用shiftwidth值
opt.expandtab = true -- 输入tab用空格代替
opt.softtabstop = 2
opt.tabstop = 2

-- indent
opt.autoindent = true -- 自动缩进，新开始的行自动上一行的缩进

-- split window
opt.splitbelow = true -- 水平拆分窗口，新窗口在下方
opt.splitright = true -- 垂直拆分窗口，新窗口在右侧

-- 剪贴板
opt.clipboard = "unnamedplus" -- 连接到系统剪贴板，和vim的寄存器概念有关

-- complete 补全
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 10 -- popup 菜单中的最大行数

opt.list = true

-- mouse
opt.mouse = "a" -- 全模式下可以使用鼠标点击和选择

-- wrap 折行设置
-- whichwrap，指定左右移动光标的键在行首或行尾可以移动到前一行或后一行
-- 字符   键        模式
-- b    <BS>       普通和可视
-- s    <Space>    普通和可视
-- h    "h"        普通和可视 (不建议)
-- l    "l"        普通和可视 (不建议)
-- <    <Left>     普通和可视
-- >    <Right>    普通和可视
-- ~    "~"        普通
-- [    <Left>     插入和替换
-- ]    <Right>    插入和替换
opt.wrap = false -- 不折行
opt.whichwrap = "<,>,[,]" -- 只设置了方向键可以换行

-- 样式
opt.cursorline = true -- 光标所在行高亮
opt.termguicolors = true -- 开启真彩色，丰富样式配置
opt.cmdheight = 0 -- 命令行高度1行
opt.showtabline = 2 -- 何时显示带有标签页标签的行 0:永远不显示，1：至少两个标签时显示，2：永远显示
opt.showmode = false

-- 备份
opt.backup = false -- 关闭备份文件
opt.swapfile = false

-- 折叠代码
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
opt.foldlevel = 99

-- https://github.com/airblade/vim-gitgutter#when-are-the-signs-updated
-- 这段文章描述了vim中gitgutter更新时机的问题,并建议设置一个较小的值。默认是4000.
-- 我不确定这个设置对gitsigns.nvim是否有影响，但是设置稍微小一点没有什么问题。
opt.updatetime = 200

-- highlight yanks
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 300, higroup = "IncSearch" })
  end,
})
