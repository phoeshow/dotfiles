return {
  'nvim-neo-tree/neo-tree.nvim',
  version = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>fe', '<cmd>Neotree filesystem reveal<cr>', desc = 'File Explorer' },
    { '<leader>ge', '<cmd>Neotree git_status reveal<cr>', desc = '[G]it Status Explorer' },
    { '<leader>be', '<cmd>Neotree buffers reveal<cr>', desc = '[B]uffer Explorer' },
    { '<leader>e', '<leader>fe', desc = 'File Explorer', remap = true },
  },
  opts = {
    window = {
      width = 30,
    },
    event_handlers = {
      {
        event = 'file_opened',
        handler = function()
          vim.cmd 'Neotree close'
        end,
      },
    },
  },
}
