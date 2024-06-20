-- 在linux和mac下，从insert模式切换到normal的时候总是切换输入法到英文输入状态。
-- windows就不管了，反正我也从来不再win下用nvim
local function switch2en()
  if vim.fn.has("linux") == 1 and vim.fn.executable("fcitx5-remote") == 1 then
    vim.fn.system("fcitx5-remote -c")
  elseif vim.fn.has("mac") == 1 then
    vim.fn.system("/usr/local/bin/im-select com.apple.keylayout.ABC")
  end
end

vim.api.nvim_create_autocmd({ "InsertLeave", "CmdlineLeave" }, {
  callback = function()
    switch2en()
  end,
})
