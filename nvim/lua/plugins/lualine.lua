return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local lualine = require("lualine")
      local lazy_status = require("lazy.status")

      local colors = {
        rosewater = "#f2d5cf",
        flamingo = "#eebebe",
        pink = "#f4b8e4",
        mauve = "#ca9ee6",
        red = "#e78284",
        maroon = "#ea999c",
        peach = "#ef9f76",
        yellow = "#e5c890",
        green = "#a6d189",
        teal = "#81c8be",
        sky = "#99d1db",
        sapphire = "#85c1dc",
        blue = "#8caaee",
        lavender = "#babbf1",
        text = "#c6d0f5",
        subtext1 = "#b5bfe2",
        subtext0 = "#a5adce",
        overlay2 = "#949cbb",
        overlay1 = "#838ba7",
        overlay0 = "#737994",
        surface2 = "#626880",
        surface1 = "#51576d",
        surface0 = "#414559",
        base = "#303446",
        mantle = "#292c3c",
        crust = "#232634",
        none = "NONE",
      }

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
      }

      local function show_macro_recording()
        local recording_register = vim.fn.reg_recording()
        if recording_register == "" then
          return ""
        else
          return "󰑋 " .. recording_register
        end
      end

      local config = {
        options = {
          component_separators = "",
          section_separators = "",
          theme = {
            normal = {
              a = { fg = colors.base, bg = colors.green, gui = "bold" },
              b = { fg = colors.text, bg = colors.surface0 },
              c = { fg = colors.text, bg = colors.none },
            },
            inactive = {
              a = { fg = colors.text, bg = colors.surface2, gui = "bold" },
              b = { fg = colors.text, bg = colors.surface1 },
              c = { fg = colors.text, bg = colors.mantle },
            },
          },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- fill component
          lualine_c = {},
          lualine_x = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {
            { "filename", path = 1 },
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {
          lualine_a = {
            {
              "buffers",
              symbols = {
                modified = " ●", -- Text to show when the buffer is modified
                alternate_file = "", -- Text to show to identify the alternate file
                directory = "", -- Text to show when the buffer is a directory
              },
            },
          },
          lualine_x = {
            {
              "branch",
              icon = "",
              color = { fg = colors.mauve, gui = "bold" },
            },
            {
              "diff",
              symbols = { added = " ", modified = " ", removed = " " },
            },
          },
        },
      }

      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end

      -- mode component
      ins_left({
        function()
          local mode_symbol = {
            ["n"] = "󰄛 ",
            ["no"] = "󰥔 ",
            ["nov"] = "󰥔 ",
            ["noV"] = "󰥔 ",
            ["no\22"] = "󰥔 ",
            ["niI"] = "󰄛 ",
            ["niR"] = "󰄛 ",
            ["niV"] = "󰄛 ",
            ["nt"] = "󰄛 ",
            ["ntT"] = "󰄛 ",
            ["v"] = "󰩭 ",
            ["vs"] = "󰩭 ",
            ["V"] = "󰩭 LINE",
            ["Vs"] = "󰩭 LINE",
            ["\22"] = "󰩭 BLOCK",
            ["\22s"] = "󰩭 BLOCK",
            ["s"] = "󰒉 ",
            ["S"] = "󰒉 LINE",
            ["\19"] = "󰒉 BLOCK",
            ["i"] = "󰏪 ",
            ["ic"] = "󰏪 ",
            ["ix"] = "󰏪 ",
            ["R"] = "REPLACE",
            ["Rc"] = "REPLACE",
            ["Rx"] = "REPLACE",
            ["Rv"] = "V-REPLACE",
            ["Rvc"] = "V-REPLACE",
            ["Rvx"] = "V-REPLACE",
            ["c"] = "󰆍 ",
            ["cv"] = "EX",
            ["ce"] = "EX",
            ["r"] = "REPLACE",
            ["rm"] = "MORE",
            ["r?"] = "CONFIRM",
            ["!"] = "SHELL",
            ["t"] = "TERMINAL",
          }

          local mode_code = vim.api.nvim_get_mode().mode

          if mode_symbol[mode_code] == nil then
            return "█ " .. mode_code .. " █"
          end

          return "█ " .. mode_symbol[mode_code] .. " █"
        end,
        color = function()
          local mode_code = vim.api.nvim_get_mode().mode
          local mode_color = {
            ["n"] = colors.teal,
            ["no"] = colors.sapphire,
            ["nov"] = colors.sapphire,
            ["noV"] = colors.sapphire,
            ["no\22"] = colors.sapphire,
            ["niI"] = colors.teal,
            ["niR"] = colors.teal,
            ["niV"] = colors.teal,
            ["nt"] = colors.teal,
            ["ntT"] = colors.teal,
            ["v"] = colors.mauve,
            ["vs"] = colors.mauve,
            ["V"] = colors.pink,
            ["Vs"] = colors.pink,
            ["\22"] = colors.pink,
            ["\22s"] = colors.pink,
            ["s"] = colors.flamingo,
            ["S"] = colors.flamingo,
            ["\19"] = colors.flamingo,
            ["i"] = colors.green,
            ["ic"] = colors.green,
            ["ix"] = colors.green,
            ["R"] = colors.yellow,
            ["Rc"] = colors.yellow,
            ["Rx"] = colors.yellow,
            ["Rv"] = colors.yellow,
            ["Rvc"] = colors.yellow,
            ["Rvx"] = colors.yellow,
            ["c"] = colors.peach,
            ["cv"] = colors.peach,
            ["ce"] = colors.peach,
            ["r"] = colors.yellow,
            ["rm"] = colors.peach,
            ["r?"] = colors.peach,
            ["!"] = colors.peach,
            ["t"] = colors.peach,
          }
          if mode_color[mode_code] == nil then
            return { fg = colors.surface2, gui = "bold" }
          end
          return { fg = mode_color[mode_code], gui = "bold" }
        end,
        padding = { left = 0, right = 1 },
      })

      ins_left({
        "filename",
        cond = conditions.buffer_not_empty,
        color = { fg = colors.peach, gui = "bold" },
      })

      ins_left({
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
          error = " ",
          warn = " ",
          info = " ",
          hint = "󰌵 ",
        },
        diagnostics_color = {
          color_error = { fg = colors.red },
          color_warn = { fg = colors.yellow },
          color_info = { fg = colors.sapphire },
          color_hint = { fg = colors.sapphire },
        },
      })

      ins_left({
        "macro-recording",
        fmt = show_macro_recording,
        color = { fg = colors.maroon, gui = "bold" },
      })

      -- right component
      ins_right({
        "encoding",
        format = string.upper,
        color = { fg = colors.sapphire, gui = "bold" },
        cond = conditions.hide_in_width,
      })

      ins_right({
        "fileformat",
        fmt = string.upper,
        icons_enabled = false,
        color = { fg = colors.green, gui = "bold" },
        cond = conditions.hide_in_width,
      })

      ins_right({
        lazy_status.updates,
        cond = lazy_status.has_updates,
        color = { fg = colors.peach },
      })

      ins_right({
        function()
          local msg = "󰌸 "
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              -- return client.name
              return "󰌷 "
            end
          end
          return msg
        end,
        icon = " LSP:",
        color = { fg = colors.flamingo },
      })

      ins_right({
        "location",
        color = { fg = colors.maroon },
        cond = conditions.hide_in_width,
      })

      ins_right({
        "progress",
        color = { fg = colors.rosewater },
      })

      lualine.setup(config)
    end,
  },
  {
    "echasnovski/mini.bufremove",
    version = "*",
    keys = {
      {
        "<C-w>",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(
              ("Save changes to %q?"):format(vim.fn.bufname()),
              "&Yes\n&No\n&Cancel"
            )
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Delete Buffer",
      },
    },
  },
}
