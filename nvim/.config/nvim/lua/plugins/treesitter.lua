require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua" },
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 150 * 1024 -- 150 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "<CR>", -- set to `false` to disable one of the mappings
  --     node_incremental = "<CR>",
  --     node_decremental = "<BS>",
  --     scope_incremental = false
  --   },
  -- },
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
})

local opt = vim.opt

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
