return {
  {
    'stevearc/conform.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      local conform = require 'conform'
      require('mason').setup {
        ensure_installed = {
          'stylua',
          'prettierd',
          'prettier',
          'eslint_d',
          'jq',
          'sql_formatter',
          'htmlbeautifier',
          'codespell',
          'trim_whitespace',
        },
      }
      conform.setup {
        formatters_by_ft = {
          lua = { 'stylua' },
          javascript = { 'prettierd', 'prettier', 'eslint_d' },
          javascriptreact = { 'prettierd', 'prettier', 'eslint_d' },
          typescript = { 'prettierd', 'prettier', 'eslint_d' },
          typescriptreact = { 'prettierd', 'prettier', 'eslint_d' },
          json = { 'prettierd', 'prettier', 'jq' },
          markdown = { 'prettierd', 'prettier' },
          ['sql'] = { 'sql_formatter' },
          ['yaml'] = { 'prettier' },
          ['css'] = { 'prettier' },
          html = { 'htmlbeautifier' },
          ['*'] = { 'codespell' },
          ['_'] = { 'trim_whitespace' },
        },
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
        lsp_fallback = true,
      }

      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*',
        callback = function(args)
          require('conform').format { bufnr = args.buf }
        end,
      })

      vim.keymap.set({ 'n', 'v' }, '<leader>ll', function()
        conform.format {
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        }
      end, {
        desc = 'Format file or range (in visual mode)',
      })
    end,
    opts = {},
  },
}
