return {
  "telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-telescope/telescope-file-browser.nvim",
  },
  keys = {
    {
      "<leader>ff",
      function()
        local builtin = require("telescope.builtin")
        builtin.find_files({
          no_ignore = false,
          hidden = true,
        })
      end,
      desc = "Lists files in your current working directory, respects .gitignore",
    },
    -- {
    --   "<leader>fe",
    --   function()
    --     local builtin = require("telescope.builtin")
    --     builtin.diagnostics()
    --   end,
    --   desc = "List Diagnostics.",
    -- },
  },
}
