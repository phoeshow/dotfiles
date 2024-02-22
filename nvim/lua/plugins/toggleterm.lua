return {
  "akinsho/toggleterm.nvim",
  version = "*",
  lazy = false,
  -- keys = {
  --   { "<C-\\>", "<cmd>ToggleTerm<cr>" },
  -- },
  config = function()
    require("toggleterm").setup({
      direction = "float",
      open_mapping = [[<C-\>]],
    })
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      float_opts = {
        border = "none",
      }, -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(
          term.bufnr,
          "n",
          "q",
          "<cmd>close<CR>",
          { noremap = true, silent = true }
        )
      end,
      -- function to run on closing the terminal
      on_close = function()
        vim.cmd("startinsert!")
        vim.cmd("bufdo e")
      end,
    })

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.api.nvim_set_keymap(
      "n",
      "<leader>gl",
      "<cmd>lua _lazygit_toggle()<CR>",
      { noremap = true, silent = true, desc = "Lazygit" }
    )
  end,
}
