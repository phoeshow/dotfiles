return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", "<cmd>Neotree filesystem reveal<cr>", desc = "Explorer" },
    },
    enabled = true,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker",
    },
    config = function()
      require("window-picker").setup({
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,
          -- filter using buffer options
          bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify", "Outline" },
            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal", "quickfix" },
          },
        },
      })
      require("neo-tree").setup({
        event_handlers = {
          {
            event = "file_opened",
            handler = function()
              vim.cmd("Neotree close")
            end,
          },
        },
        window = {
          width = 30,
        },
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        vim.keymap.set(
          "n",
          "<C-h>",
          api.node.open.horizontal,
          opts("Open: Horizontal Split")
        )
        vim.keymap.set(
          "n",
          ".",
          api.tree.change_root_to_node,
          opts("Change root")
        )
      end
      local HEIGHT_RATIO = 0.8
      local WIDTH_RATIO = 0.5

      require("nvim-tree").setup({
        on_attach = my_on_attach,
        view = {
          width = function()
            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
          end,
          float = {
            enable = true,
            open_win_config = function()
              local screen_w = vim.opt.columns:get()
              local screen_h = vim.opt.lines:get()
              local window_w = screen_w * WIDTH_RATIO
              local window_h = screen_h * HEIGHT_RATIO

              local window_w_int = math.floor(window_w)
              local window_h_int = math.floor(window_h)
              local center_x = (screen_w - window_w) / 2
              local center_y = ((vim.opt.lines:get() - window_h) / 2)
                - vim.opt.cmdheight:get()
              return {
                border = "single",
                relative = "editor",
                row = center_y,
                col = center_x,
                width = window_w_int,
                height = window_h_int,
              }
            end,
          },
        },
        renderer = {
          indent_markers = {
            enable = true,
          },
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
          file_popup = {
            open_win_config = {
              border = "single",
            },
          },
        },
        modified = {
          enable = true,
        },
        update_focused_file = {
          enable = true,
        },
      })
    end,
  },
}
--
