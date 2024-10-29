return {
  'folke/trouble.nvim',
  opts = {
    focus = true,
  },
  cmd = 'Trouble',
  keys = {
    {
      '<leader>td',
      '<cmd>Trouble diagnostics toggle filter.buf=0 <cr>',
      desc = '[T]oggle [D]iagnostics current buffer',
    },
    {
      '<leader>tD',
      '<cmd>Trouble diagnostics toggle focus=true<cr>',
      desc = '[T]oggle [D]iagnostics all',
    },
    {
      '<leader>ts',
      '<cmd>Trouble symbols toggle win.position=right focus=true<cr>',
      desc = '[T]oggle Doucment[S]ymbols',
    },
    {
      '<leader>tf',
      '<cmd>Trouble quickfix toggle win.position=right focus=true<cr>',
      desc = '[T]oggle quick[F]ix list',
    },
  },
}
