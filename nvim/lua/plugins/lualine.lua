return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",

    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local lazy_status = require("lazy.status")
      local function show_macro_recording()
        local recording_register = vim.fn.reg_recording()
        if recording_register == "" then
          return ""
        else
          return "Recording @" .. recording_register
        end
      end
      local colors = {
        black = "#292c3c",
        white = "#c6d0f5",
        red = "#e78284",
        green = "#a6d189",
        blue = "#8caaee",
        yellow = "#e5c890",
        gray = "#51576d",
        darkgray = "#292c3c",
        lightgray = "#626880",
        inactivegray = "#414559",
      }
      local my_theme = {
        normal = {
          a = { bg = colors.blue, fg = colors.black, gui = "bold" },
          b = { bg = colors.gray, fg = colors.white },
          c = { bg = colors.darkgray, fg = colors.white },
        },
        insert = {
          a = { bg = colors.green, fg = colors.black, gui = "bold" },
          b = { bg = colors.gray, fg = colors.white },
          c = { bg = colors.darkgray, fg = colors.white },
        },
        visual = {
          a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
          b = { bg = colors.gray, fg = colors.white },
          c = { bg = colors.darkgray, fg = colors.white },
        },
        replace = {
          a = { bg = colors.red, fg = colors.black, gui = "bold" },
          b = { bg = colors.gray, fg = colors.white },
          c = { bg = colors.darkgray, fg = colors.white },
        },
        command = {
          a = { bg = colors.green, fg = colors.black, gui = "bold" },
          b = { bg = colors.gray, fg = colors.white },
          c = { bg = colors.darkgray, fg = colors.white },
        },
        inactive = {
          a = { bg = colors.darkgray, fg = colors.lightgray, gui = "bold" },
          b = { bg = colors.darkgray, fg = colors.lightgray },
          c = { bg = colors.darkgray, fg = colors.lightgray },
        },
      }
      require("lualine").setup({
        options = {
          icons_enabled = true,
          -- theme = "catppuccin",
          theme = my_theme,
          component_separators = { left = "|", right = "|" },
          section_separators = { left = "", right = "" },
          always_divide_middle = true,
          globalstatus = false,
        },
        sections = {
          lualine_a = {
            "mode",
          },
          lualine_b = {
            "branch",
            {
              "diff",
              symbols = { added = " ", modified = " ", removed = " " },
            },
            {
              "diagnostics",
            },
            {
              "macro-recording",
              fmt = show_macro_recording,
            },
          },
          lualine_c = {
            { "filename" },
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = {
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
              color = { fg = "#ff9e64" },
            },
            {
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
              icon = " :",
              color = { fg = "#ffffff" },
            },
          },
          lualine_z = {
            "progress",
            "location",
          },
        },
        inactive_sections = {
          lualine_a = { { "filename", path = 1 } },
          lualine_b = {},
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
        },
        extensions = {
          "neo-tree",
          "symbols-outline",
          "toggleterm",
          "mason",
          "nvim-tree",
        },
      })
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
