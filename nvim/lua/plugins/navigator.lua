return {
  {
    'numToStr/Navigator.nvim',
    config = function()
      ---@class Kitty:Vi
      local Kitty = require('Navigator.mux.vi'):new()
      ---@return Kitty
      function Kitty:new()
        assert(os.getenv 'TERM' == 'xterm-kitty', '[Navigator] Kitty is not running!')

        local U = require 'Navigator.utils'

        local state = {
          execute = function(arg)
            return U.execute(string.format('kitty @ %s', arg))
          end,
          direction = { h = 'left', j = 'bottom', k = 'top', l = 'right' },
        }

        self.__index = self
        return setmetatable(state, self)
      end

      ---@param direction Direction
      ---@return Kitty
      function Kitty:navigate(direction)
        self.execute(string.format('kitten navigator.py %s', self.direction[direction]))
        return self
      end

      local ok_mux, mux = pcall(function()
        return Kitty:new()
      end)

      require('Navigator').setup {
        mux = ok_mux and mux or 'auto',
      }
    end,
  },
}
