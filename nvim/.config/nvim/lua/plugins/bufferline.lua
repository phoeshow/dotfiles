local status, bufferline = pcall(require, 'bufferline')
if not status then return end


bufferline.setup {
  options = {
    indicator = { style = 'icon', icon = ' 󰷉' },
    diagnostics = 'nvim_lsp',
    separator_style = 'thin',
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true,
      }
    }
  }

}
