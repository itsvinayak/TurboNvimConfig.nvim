require("lua.NeoMinimalVim.config.init")
require("lua.NeoMinimalVim.keymapping.init")
require("lua.NeoMinimalVim.plugins.init")

vim.cmd([[command! CheckHealth lua require('main.health').check()]])

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])


require("notify")("configuration loaded . . .", "info")