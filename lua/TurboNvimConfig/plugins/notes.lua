return {
  {
    'itsvinayak/nvim-notes.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim', -- Add Telescope as a dependency
      'folke/which-key.nvim', -- Add WhichKey as a dependency (optional)
    },
    config = function()
      require('notes').setup {
        -- Optional configurations
        path = '~/.my_notes', -- Custom path for notes (default is '~/.notes')
        log_enabled = false, -- Enable logging (default is false)
        log_level = 'INFO', -- Set log level to INFO
        filetype = 'txt', -- Sets the notes filetype default is 'md'
      }

      -- Add WhichKey mappings (optional)
      if pcall(require, 'which-key') then
        local wk = require 'which-key'
        wk.add {
          { '<leader>nw', 'New Note' },
          { '<leader>nf', 'Find Note' },
          { '<leader>ng', 'Get Note' },
        }
      end
    end,
  },
}
