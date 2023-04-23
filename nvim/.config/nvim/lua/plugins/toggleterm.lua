local status, toggleterm = pcall(require, 'toggleterm')

if not status then return end

toggleterm.setup({
  open_mapping = [[<c-\>]],
  direction = 'horizontal',
  close_on_exit = true,
  size = 20,
})
