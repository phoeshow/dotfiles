-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- 自动切换输入法
vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
  callback = function()
    if vim.fn.has("linux") == 1 and vim.fn.executable("fcitx5-remote") == 1 then
      vim.fn.system("fcitx5-remote -c")
    elseif vim.fn.has("mac") == 1 then
      vim.fn.system("/usr/local/bin/im-select com.apple.keylayout.ABC")
    end
  end,
})
