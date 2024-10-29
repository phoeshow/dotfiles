return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.indentscope').setup {
        options = {
          border = 'both',
          try_as_border = true,
        },
        symbol = '│',
      }

      -- buffer remove
      require('mini.bufremove').setup()
      vim.keymap.set('n', '<leader>bd', function()
        local bd = require('mini.bufremove').delete
        if vim.bo.modified then
          local choice = vim.fn.confirm(('Save changes to %q?'):format(vim.fn.bufname()), '&Yes\n&No\n&Cancel')
          if choice == 1 then
            vim.cmd.write()
            bd(0)
          elseif choice == 2 then
            bd(0, true)
          end
        else
          bd(0)
        end
      end, { desc = '[B]uffer [D]elete' })

      -- hipatterns
      local hipatterns = require 'mini.hipatterns'
      hipatterns.setup {
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
  },
}
