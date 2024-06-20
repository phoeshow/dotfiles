local is_kitty = os.getenv("TERM") == "xterm-kitty"
return {
  {
    "numToStr/Navigator.nvim",
    enabled = not is_kitty,
    config = function()
      require("Navigator").setup({})
      vim.keymap.set({ "n", "t" }, "<A-h>", "<CMD>NavigatorLeft<CR>")
      vim.keymap.set({ "n", "t" }, "<A-l>", "<CMD>NavigatorRight<CR>")
      vim.keymap.set({ "n", "t" }, "<A-k>", "<CMD>NavigatorUp<CR>")
      vim.keymap.set({ "n", "t" }, "<A-j>", "<CMD>NavigatorDown<CR>")
      vim.keymap.set({ "n", "t" }, "<A-p>", "<CMD>NavigatorPrevious<CR>")
    end,
  },
  {
    "knubie/vim-kitty-navigator",
    enabled = is_kitty,
    init = function()
      vim.g.kitty_navigator_no_mappings = 1
      vim.keymap.set({ "n", "t" }, "<A-h>", "<cmd>KittyNavigateLeft<cr>")
      vim.keymap.set({ "n", "t" }, "<A-j>", "<cmd>KittyNavigateDown<cr>")
      vim.keymap.set({ "n", "t" }, "<A-k>", "<cmd>KittyNavigateUp<cr>")
      vim.keymap.set({ "n", "t" }, "<A-l>", "<cmd>KittyNavigateRight<cr>")
    end,
  },
}
