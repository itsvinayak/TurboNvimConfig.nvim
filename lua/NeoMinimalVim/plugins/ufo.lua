local setup = {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
}

function setup.config()
  -- folds config
  vim.o.foldcolumn = '1' -- '0' is not bad
  vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true

  -- keymapping in folds
  vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
  vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
  vim.keymap.set('n', 'fo', '<cmd>foldopen<CR>')
  vim.keymap.set('n', 'fc', '<cmd>foldclose<CR>')
  vim.keymap.set('n', 'zK', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
      vim.lsp.buf.hover()
    end
  end, {
    desc = 'Peek Fold',
  })

  -- required lsp in folds
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  local language_servers = require('lspconfig').util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
  for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup {
      capabilities = capabilities,
      -- you can add other fields for setting up lsp server in this table
    }
  end

  -- required lsp in folds
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  local language_servers = require('lspconfig').util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
  for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup {
      capabilities = capabilities,
      -- you can add other fields for setting up lsp server in this table
    }
  end
  require('ufo').setup {
    provider_selector = function(bufnr, filetype, buftype)
      return { 'lsp', 'indent' }
    end,
    preview = {
      win_config = {
        border = { '', '─', '', '', '', '─', '', '' },
        winhighlight = 'Normal:Folded',
        winblend = 0,
      },
      mappings = {
        scrollU = '<C-u>',
        scrollD = '<C-d>',
        jumpTop = '[',
        jumpBot = ']',
      },
    },
  }
end

return setup
