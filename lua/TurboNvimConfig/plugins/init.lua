if vim.fn.has 'nvim' == 0 then
  vim.api.nvim_echo({ { 'LazyVim requires Neovim >= 0.9.0\n', 'ErrorMsg' }, { 'Press any key to exit', 'MoreMsg' } }, true, {})
  vim.fn.getchar()
  vim.cmd [[quit]]
  return {}
end

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

-- Plugins
-- ============================================================================
require('lazy').setup {
  spec = {
    require 'TurboNvimConfig.plugins.lualine',
    require 'TurboNvimConfig.plugins.lsp',
    require 'TurboNvimConfig.plugins.debug',
    require 'TurboNvimConfig.plugins.dashboard',
    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
    { 'github/copilot.vim' }, -- Copilot AI
    require 'TurboNvimConfig.plugins.comment',
    require 'TurboNvimConfig.plugins.neo-tree',
    require 'TurboNvimConfig.plugins.indent-blankline',
    { 'wakatime/vim-wakatime' },
    require 'TurboNvimConfig.plugins.which-key',
    require 'TurboNvimConfig.plugins.undotree',
    require 'TurboNvimConfig.plugins.zen-mode',
    require 'TurboNvimConfig.plugins.colorscheme',
    require 'TurboNvimConfig.plugins.telescope',
    require 'TurboNvimConfig.plugins.git',
    require 'TurboNvimConfig.plugins.conform',
    require 'TurboNvimConfig.plugins.treesitter',
    require 'TurboNvimConfig.plugins.barbar',
    require 'TurboNvimConfig.plugins.ufo',
    require 'TurboNvimConfig.plugins.colorizer',
    require 'TurboNvimConfig.plugins.neoscroll',
    -- require 'TurboNvimConfig.plugins.satellite',
    require 'TurboNvimConfig.plugins.neominimap',
    require 'TurboNvimConfig.plugins.fidget',
    require 'TurboNvimConfig.plugins.trouble',
    require 'TurboNvimConfig.plugins.highlight-undo',
    -- require 'TurboNvimConfig.plugins.image',
  },
  checker = { enabled = true },
}

-- ===============================================================================
