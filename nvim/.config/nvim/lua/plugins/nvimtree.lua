return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      local function my_on_attach(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)


        vim.keymap.set('n', '.', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
        vim.keymap.set('n', 'v', api.node.open.vertical,opts('Open: Vertical Split'))
        vim.keymap.set('n', 'h', api.node.open.horizontal, opts('Open: Horizontal Split'))
        vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
        vim.keymap.set('n', 'P', function()
          local node = api.tree.get_node_under_cursor()
          print(node.absolute_path)
        end, opts('Print Node Path'))

      end

      require("nvim-tree").setup { -- project plugin 需要这样设置
        update_cwd = true,
        update_focused_file = { enable = true, update_cwd = true },
        -- 隐藏 .文件 和 node_modules 文件夹
        filters = { dotfiles = false },
        view = {
          -- 宽度
          width = 30,
          -- 也可以 'right'
          side = 'left',
          -- 隐藏根目录
          hide_root_folder = false,
          -- 不显示行数
          number = false,
          relativenumber = false,
          -- 显示图标
          signcolumn = 'yes'
        },
        on_attach = my_on_attach,
        actions = {
          open_file = {
            -- 首次打开大小适配
            resize_window = true,
            -- 打开文件时关闭
            quit_on_open = true
          }
        }
      }
      -- auto close
      vim.api.nvim_create_autocmd({"QuitPre"}, {
          callback = function() vim.cmd("NvimTreeClose") end,
      })
    end
  }
}
