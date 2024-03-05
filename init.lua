require("lua.NeoMinimalVim.config.init")
require("lua.NeoMinimalVim.keymapping.init")
require("lua.NeoMinimalVim.plugins.init")

vim.cmd([[command! CheckHealth lua require('main.health').check()]])
