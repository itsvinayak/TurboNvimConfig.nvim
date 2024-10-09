local setup = {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  cmd = 'Neotree',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
    {
      's1n7ax/nvim-window-picker',
      version = '2.*',
      config = function()
        require('window-picker').setup {
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { 'terminal', 'quickfix' },
            },
          },
        }
      end,
    },
  },
  config = function()
    if pcall(require, 'which-key') then
      local wk = require 'which-key'
      wk.add {
        ['<leader>'] = {
          n = {
            name = '+neotree',
            t = { '<cmd>NeotreeToggle<CR>', 'Toggle' },
            r = { '<cmd>NeotreeRefresh<CR>', 'Refresh' },
            f = { '<cmd>NeotreeFind<CR>', 'Find' },
            c = { '<cmd>NeotreeClose<CR>', 'Close' },
          },
        },
      }
    end
  end,
}

return setup
