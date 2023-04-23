local status, Comment = pcall(require, 'Comment')

if not status then return end

Comment.setup({
  toggler = { line = "<C-_>" },
  opleader = { block = "<C-_>" }
})
