local setup = {
  'vhyrro/luarocks.nvim',
  priority = 1001, -- this plugin needs to run before anything else
  opts = {
    rocks = { 'magick' },
  },

  '3rd/image.nvim',
  dependencies = { 'luarocks.nvim' },
  config = function()
    require('image').setup {
      backend = 'ueberzug', -- or "ueberzug"
      max_height_window_percentage = 50,
      hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.svg' },
    }
  end,
}

return setup
