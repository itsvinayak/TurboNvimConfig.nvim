local setup = {
  'j-hui/fidget.nvim',
  opts = {},
  config = function()
    require('fidget').setup()
  end,
}

return setup
