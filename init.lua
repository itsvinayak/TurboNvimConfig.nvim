if vim.loader then
  vim.loader.enable()
end

require 'TurboNvimConfig.config.init'
require 'TurboNvimConfig.keymapping.init'
require 'TurboNvimConfig.plugins.init'
require 'custom.plugins.init'

vim.cmd [[command! CheckHealth lua require('TurboNvimConfig.health').check()]]
vim.o.background = 'dark' -- or "light" for light mode

require('fidget').notify('TurboNvimConfig - nvim config loaded', vim.log.levels.INFO)

vim.cmd 'colorscheme gruvbox'
