-- local withTmux = os.getenv("TMUX") ~= nil

return {
  {
    "knubie/vim-kitty-navigator",
    -- enabled = not withTmux,
    enabled = false,
    lazy = false,
    init = function()
      -- for vim-kitty-navigator plugin
      vim.g.kitty_navigator_no_mappings = 1
      vim.g.kitty_navigator_enable_stack_layout = 0
    end,
    config = function()
      vim.keymap.set(
        "n",
        "<A-h>",
        "<cmd>KittyNavigateLeft<cr>",
        { noremap = true, silent = true }
      )
      vim.keymap.set(
        "n",
        "<A-j>",
        "<cmd>KittyNavigateDown<cr>",
        { noremap = true, silent = true }
      )
      vim.keymap.set(
        "n",
        "<A-k>",
        "<cmd>KittyNavigateUp<cr>",
        { noremap = true, silent = true }
      )
      vim.keymap.set(
        "n",
        "<A-l>",
        "<cmd>KittyNavigateRight<cr>",
        { noremap = true, silent = true }
      )
    end,
  },
  {
    "alexghergh/nvim-tmux-navigation",
    enabled = true,
    config = function()
      local nvim_tmux_nav = require("nvim-tmux-navigation")

      nvim_tmux_nav.setup({
        disable_when_zoomed = true, -- defaults to false
      })
      vim.keymap.set("n", "<A-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
      vim.keymap.set("n", "<A-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
      vim.keymap.set("n", "<A-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
      vim.keymap.set("n", "<A-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
      vim.keymap.set("n", "<A-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
      vim.keymap.set("n", "<A-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
    end,
  },
}
