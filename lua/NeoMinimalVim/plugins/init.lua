if vim.fn.has 'nvim-0.9.0' == 0 then
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
  require 'NeoMinimalVim.plugins.lualine',
  require 'NeoMinimalVim.plugins.debug',
  require 'NeoMinimalVim.plugins.dashboard',
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { 'github/copilot.vim' }, -- Copilot AI
  { 'rcarriga/nvim-notify' }, -- Notifications
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
  },
  require 'NeoMinimalVim.plugins.comment',
  require 'NeoMinimalVim.plugins.neo-tree',
  require 'NeoMinimalVim.plugins.indent-blankline',
  { 'wakatime/vim-wakatime' },
  require 'NeoMinimalVim.plugins.which-key',
  require 'NeoMinimalVim.plugins.undotree',
  require 'NeoMinimalVim.plugins.zen-mode',
  require 'NeoMinimalVim.plugins.gruvbox',
  require 'NeoMinimalVim.plugins.lsp',
  require 'NeoMinimalVim.plugins.neoclip',
  require 'NeoMinimalVim.plugins.telescope',
  require 'NeoMinimalVim.plugins.git',
  require 'NeoMinimalVim.plugins.conform',
}

-- ===============================================================================

-- setup
require 'NeoMinimalVim.plugins.lspSetup'
require 'NeoMinimalVim.plugins.ufoSetup'
require 'NeoMinimalVim.plugins.whichKeySetup'
require 'NeoMinimalVim.plugins.indentBlanklineSetup'
require 'NeoMinimalVim.plugins.telescopeSetup'
require 'NeoMinimalVim.plugins.neoclipSetup'
require 'NeoMinimalVim.plugins.conformSetup'
