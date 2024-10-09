local setup = {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && yarn install',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
  end,
  ft = { 'markdown' },
  config = function()
    if pcall(require, 'which-key') then
      local wk = require 'which-key'
      wk.register {
        ['<leader>mp'] = {
          name = '+markdown-preview',
          t = { '<cmd>MarkdownPreviewToggle<CR>', 'Toggle' },
          s = { '<cmd>MarkdownPreviewStop<CR>', 'Stop' },
        },
      }
    end
  end,
}

return setup
