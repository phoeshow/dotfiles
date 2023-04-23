local opt = vim.opt

-- encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- line number
opt.number = true         -- 开启行号显示
opt.relativenumber = true -- 开启相对行号
opt.signcolumn = "yes"    -- 开启标记列
opt.scrolloff = 8         -- 滚动时开启8行的边距，滚动到底部和顶部的时候看起来舒服一些
opt.sidescrolloff = 5     -- 水平滚动时开启5列边距

-- search
opt.ignorecase = true -- 搜索时忽略大小写
opt.smartcase = true  -- 如果有大写时，自动停止忽略大小写

-- <tab> 行为
--[[
tabstop表示一个tab显示多宽。
softtabstop是编辑的时候按tab键缩进的宽度。如果它和tabstop不相等，可能有空格。
比如tabstop为8，softtabstop为4，按第一个tab时，插入4个空格，再按一次，变成一个tab。
比如tabstop为4，softtabstop为6，按第一个tab时，变成一个tab+2个空格。再按一下，变成3个tab。
shiftwidth是调整格式时，比如使用<<和>>命令，缩进的宽度。
expandtab，是插入tab时，把tab变成空格。
]]
opt.shiftwidth = 2   -- 缩进和自动缩进的步数设置为2
opt.smarttab = true  -- 插入<tab>时使用shiftwidth设置的值
opt.expandtab = true -- 在输入<tab>输入空格
opt.softtabstop = 2
opt.tabstop = 2
-- indent
opt.autoindent = true         -- 自动缩进，新开始的行自动复制上一行的缩进
-- split window 行为
opt.splitbelow = true         -- 新窗口在当前窗口下方打开
opt.splitright = true         -- 新窗口在当前窗口右侧打开
-- clipboard
opt.clipboard = "unnamedplus" -- 连接系统剪贴板，抽空还是看看vim中寄存器的概念
-- complete
opt.wildmenu = true           -- 菜单模式命令补全
opt.completeopt = "menu,menuone,noinsert,noselect"
opt.pumheight = 10            -- Maximum number of items to show in the popup menu
-- mouse
opt.mouse = "a"
-- wrap
opt.wrap = false          -- 无论多长都不换行
opt.whichwrap = "<,>,[,]" -- 方向键左右可以换行移动(不是hl，而是方向键的左右)

-- theme
opt.cursorline = true -- 光标行高亮
opt.termguicolors = true
opt.cmdheight = 1
opt.showtabline = 2 -- 总是显示tab条
opt.showmode = false

opt.backup = false --  close backup file
