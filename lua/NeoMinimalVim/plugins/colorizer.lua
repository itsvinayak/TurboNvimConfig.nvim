local setup = {
  'norcalli/nvim-colorizer.lua',
}

function setup.config()
  require('colorizer').setup()
end

return setup
