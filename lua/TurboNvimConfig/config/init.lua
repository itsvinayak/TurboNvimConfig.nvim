-- Set <space> as the leader key
-- See `:help mapleader`

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.mouse = 'a'
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim - same register
vim.opt.clipboard = 'unnamedplus'

vim.opt.breakindent = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.config/nvim/undodir'
vim.opt.undofile = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append '@-@'

-- horizontal line
vim.opt.cursorline = true

vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.autowrite = true

vim.reload_config_on_save = false
vim.opt.termguicolors = true
vim.opt.guicursor = 'n-v-c:block-Cursor/lCursor-blinkon0,i-ci-ve:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor'
vim.opt.nu = true
vim.opt.relativenumber = true

vim.cmd 'filetype plugin on'
vim.cmd 'syntax on'

-- hiding tmux status line
vim.cmd [[
  augroup DisableTmuxStatus
    autocmd!
    autocmd VimEnter * silent !tmux set status off
    autocmd VimLeave * silent !tmux set status on
  augroup END
]]

-- Define a group for the autocmd
local yank_group = 'myYankGroup'

-- Set up the autocmd for TextYankPost event
vim.api.nvim_exec2([[
  augroup ]] .. yank_group .. [[
    autocmd!
    autocmd TextYankPost * lua vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 40 })
  augroup END
]], {})

return {}
