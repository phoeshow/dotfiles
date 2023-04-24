local augroup = vim.api.nvim_create_augroup("FoldCode", {})

vim.api.nvim_create_autocmd( "BufEnter", {
  group = augroup,
  command = "normal zR",
})
