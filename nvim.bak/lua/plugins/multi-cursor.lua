return {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    local VM_maps = {
      ["Add Cursor Down"] = "<C-j>",
      ["Add Cursor Up"] = "<C-k>",
    }
    vim.g.VM_maps = VM_maps
  end,
}
