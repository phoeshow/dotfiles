-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  event = 'VeryLazy',
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    local map = vim.keymap.set

    map('n', '<F5>', function()
      dap.continue()
    end, { desc = 'Debug: Start/Continue' })
    map('n', '<F10>', function()
      dap.step_over()
    end, { desc = 'Debug: Step Over' })
    map('n', '<F11>', function()
      dap.step_into()
    end, { desc = 'Debug: Step Into' })
    map('n', '<F12>', function()
      dap.step_out()
    end, { desc = 'Debug: Step Out' })

    map('n', '<leader>db', function()
      dap.toggle_breakpoint()
    end, { desc = 'Debug: Toggle Breakpotin' })
    map('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition:')
    end, { desc = 'Debug: Set Breakpoint' })
    map('n', '<F7>', function()
      dapui.toggle()
    end, { desc = 'Debug: See last session result' })

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end,
}
