local setup = {
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require('mini.ai').setup()
      require('mini.align').setup()
      -- require('mini.base16').setup()
      require('mini.basics').setup {
        options = {
          extra_ui = true,
          win_borders = 'double',
        },
        mappings = {
          windows = true,
        },
      }
      require('mini.bracketed').setup()
      require('mini.bufremove').setup()
      require('mini.colors').setup()
      require('mini.cursorword').setup()
      require('mini.doc').setup()
      require('mini.extra').setup()
      require('mini.fuzzy').setup()
      require('mini.hipatterns').setup()
      require('mini.jump').setup()
      require('mini.jump2d').setup()
      require('mini.map').setup()
      require('mini.misc').setup()
      require('mini.move').setup()
      require('mini.pick').setup {
        mappings = {
          choose_in_vsplit = '<C-CR>',
        },
        options = {
          use_cache = true,
        },
        window = {
          config = {
            border = 'rounded',
          },
        },
      }
      require('mini.splitjoin').setup()
      require('mini.surround').setup()
    end,
  },
}

return setup
