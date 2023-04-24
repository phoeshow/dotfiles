local status, bufferline = pcall(require, "bufferline")
if not status then
  return
end

bufferline.setup({
  options = {
    indicator = { style = "icon", icon = "▎" },
    diagnostics = "nvim_lsp",
    themable = true,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true,
      },
    },
  },
  highlights = require("catppuccin.groups.integrations.bufferline").get(),
})
