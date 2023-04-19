return {
  "lukas-reineke/indent-blankline.nvim",
  -- config = function ()
  --   require()
  --
  -- end
  opts = {
    show_current_context = true,
    show_current_context_start = true,
    -- 空行占位
    space_char_blankline = " ",
    -- :echo &filetype
    filetype_exclude = {
      "dashboard",
      "packer",
      "terminal",
      "help",
      "log",
      "markdown",
      "TelescopePrompt",
      "lsp-installer",
      "lspinfo",
      "toggleterm",
    },
    -- 竖线样式
    -- char = '¦'
    -- char = '┆'
    -- char = '│'
    -- char = "⎸",
    char = "▏",
  }
}
