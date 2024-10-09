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
        log_enabled = true, -- Enable logging (default is false)
        log_level = 'INFO', -- Set log level to INFO
        filetype = 'txt', -- Sets the notes filetype default is 'md'
      }

      -- Setup WhichKey mappings using `add`
      if pcall(require, 'which-key') then
        local wk = require 'which-key'

        -- Corrected mappings using the new `add` method
        wk.add {
          ['<leader>n'] = { name = 'Notes' }, -- Group name for notes

          ['<leader>nw'] = { ':Notes write<CR>', 'Write a new note' },
          ['<leader>nf'] = { ':Notes find<CR>', 'Find notes by title' },
          ['<leader>ng'] = { ':Notes get<CR>', 'Get a list of all notes' },
        }
      end
    end,
  },
}
