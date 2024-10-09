return {
  {
    'mbbill/undotree',
    config = function()
      if pcall(require, 'which-key') then
        local wk = require 'which-key'
        wk.add {
          { '<leader>u', '<cmd>Telescope undo<CR>', desc = 'Telescope Undo' },
        }
      end
    end,
  },
}
