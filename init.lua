require 'NeoMinimalVim.config.init'
require 'NeoMinimalVim.keymapping.init'
require 'NeoMinimalVim.plugins.init'
require 'custom.plugins.init'

vim.cmd [[command! CheckHealth lua require('main.health').check()]]
vim.o.background = 'dark' -- or "light" for light mode

require 'notify'('configuration loaded . . .', 'info')
vim.cmd 'colorscheme gruvbox'
