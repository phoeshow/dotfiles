return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'lua',
        'bash',
        'markdown',
        'markdown_inline',
        'vim',
        'vimdoc',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- select in function
            ['if'] = {
              query = '@function.inner',
              desc = 'Select inner of a function',
            },
            ['af'] = {
              query = '@fucntion.outer',
              desc = 'Select outer of a function',
            },
            -- select in function parameter
            ['ia'] = {
              query = '@parameter.inner',
              desc = 'Select inner of a parameter',
            },
            ['aa'] = {
              query = '@parameter.outer',
              desc = 'Select outer of a parameter',
            },
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']f'] = {
              query = '@function.outer',
              desc = 'Goto next Function',
            },
            [']a'] = {
              query = '@parameter.inner',
              desc = 'Goto next Parameter',
            },
          },
          goto_previous_start = {
            ['[f'] = {
              query = '@fucntion.outer',
              desc = 'Goto previous Function',
            },
            ['[a'] = {
              query = '@parameter.inner',
              desc = 'Goto previous Parameter',
            },
          },
        },
      },
    },
  },
}
