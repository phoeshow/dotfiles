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
          section_separators = { left = "" },
          globalstatus = true,
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
            ["v"] = "󰩭 VISUAL",
            ["vs"] = "󰩭 VISUAL",
            ["V"] = "󰩭 V-LINE",
            ["Vs"] = "󰩭 V-LINE",
            ["\22"] = "󰩭 V-BLOCK",
            ["\22s"] = "󰩭 V-BLOCK",
            ["s"] = "󰒉 ",
            ["S"] = "󰒉 S-LINE",
            ["\19"] = "󰒉 S-BLOCK",
            ["i"] = "󰏪 INSERT",
            ["ic"] = "󰏪 INSERT",
            ["ix"] = "󰏪 INSERT",
            ["R"] = "REPLACE",
            ["Rc"] = "REPLACE",
            ["Rx"] = "REPLACE",
            ["Rv"] = "V-REPLACE",
            ["Rvc"] = "V-REPLACE",
            ["Rvx"] = "V-REPLACE",
            ["c"] = "󰆍 CMD",
            ["cv"] = "EX",
            ["ce"] = "EX",
            ["r"] = "REPLACE",
            ["rm"] = "MORE",
            ["r?"] = "CONFIRM",
            ["!"] = "SHELL",
            ["t"] = "TERMINAL",
          }

          local mode_code = vim.api.nvim_get_mode().mode
          local dec_symbol = "󰣐 "

          if mode_symbol[mode_code] == nil then
            return dec_symbol .. mode_code .. dec_symbol
          end

          return dec_symbol .. mode_symbol[mode_code] .. dec_symbol
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

      -- filetype icon
      ins_left({
        "filetype",
        colored = true,
        icon_only = true,
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
          local clients = vim.lsp.get_clients()
          if #clients ~= 0 then
            return "󰒓"
          else
            return "󱏎"
          end
        end,
        color = { fg = colors.flamingo },
      })

      ins_right({
        function()
          local ok, lint = pcall(require, "lint")

          if not ok then
            return ""
          end

          local linters = lint.get_running()

          if #linters == 0 then
            return "󰦕"
          end

          return "󱉶 " .. table.concat(linters, ", ")
        end,
        color = { fg = colors.maroon },
      })

      ins_right({
        "location",
        color = { fg = colors.mauve },
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
