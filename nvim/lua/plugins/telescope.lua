return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local telescope = require 'telescope'

    telescope.setup {
      defaults = {
        borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      },
    }
    telescope.load_extension 'fzf'

    local builtin = require 'telescope.builtin'
    local map = vim.keymap.set

    map('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
    map('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
    map('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    map('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
    map('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
  end,
}
