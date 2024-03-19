local setup = {
  'VonHeikemen/lsp-zero.nvim',
  event = 'InsertEnter',
  branch = 'v2.x',
  dependencies = { -- LSP Support
    { 'neovim/nvim-lspconfig' }, -- Required
    { 'zbirenbaum/copilot-cmp' },
    { -- Optional
      'williamboman/mason.nvim',
      build = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional
    -- Autocompletion
    { 'hrsh7th/nvim-cmp' }, -- Required
    { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    { 'L3MON4D3/LuaSnip' }, -- Required
    { 'rafamadriz/friendly-snippets' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'saadparwaiz1/cmp_luasnip' },
  },
}

function setup.config()
  local mason = require 'mason'
  local mason_lspconfig = require 'mason-lspconfig'
  local cmp = require 'cmp'
  local lspconfig = require 'lspconfig'
  local lsp_zero = require 'lsp-zero'
  local luasnip = require 'luasnip'

  -- hilighting for LSP diagnostics
  vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', {
    fg = '#6CC644',
  })
  vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', {
    fg = '#FF9000',
  })
  vim.api.nvim_set_hl(0, 'CmpItemKindBuffer', {
    fg = '#00A8E8',
  })
  vim.api.nvim_set_hl(0, 'CmpItemKindPath', {
    fg = '#FF9000',
  })
  vim.api.nvim_set_hl(0, 'CmpItemKindCmdline', {
    fg = '#FF9000',
  })

  -- Configure LSP
  lsp_zero.preset 'recommended'
  lsp_zero.preset 'diagnostic'
  lsp_zero.preset 'formatting'

  -- Ensure installation of multiple language servers
  require('mason').setup {}
  mason_lspconfig.setup {
    ensure_installed = { 'tsserver', 'rust_analyzer', 'lua_ls', 'eslint', 'dockerls', 'marksman', 'html', 'jsonls' },
    handlers = {
      lsp_zero.default_setup,
    },
  }

  -- Set LSP keybindings
  lsp_zero.on_attach(function(client, bufnr)
    local opts = {
      buffer = bufnr,
      remap = false,
    }

    local keymap = vim.keymap
    local diagnostic = vim.diagnostic
    keymap.set('n', 'gr', function()
      vim.lsp.buf.references()
    end, opts)
    keymap.set('n', 'gd', function()
      vim.lsp.buf.definition()
    end, opts)
    keymap.set('n', 'K', function()
      vim.lsp.buf.hover()
    end, opts)
    keymap.set('n', '<leader>vws', function()
      vim.lsp.buf.workspace_symbol()
    end, opts)
    keymap.set('n', '<leader>vd', function()
      diagnostic.setloclist()
    end, opts)
    keymap.set('n', '[d', function()
      diagnostic.goto_next()
    end, opts)
    keymap.set('n', ']d', function()
      diagnostic.goto_prev()
    end, opts)
    keymap.set('n', '<leader>vca', function()
      vim.lsp.buf.code_action()
    end, opts)
    keymap.set('n', '<leader>vrr', function()
      vim.lsp.buf.references()
    end, opts)
    keymap.set('n', '<leader>vrn', function()
      vim.lsp.buf.rename()
    end, opts)
    keymap.set('i', '<C-h>', function()
      vim.lsp.buf.signature_help()
    end, opts)
  end)

  -- Set up nvim-cmp
  local cmp_select = {
    behavior = cmp.SelectBehavior.Select,
  }
  local cmp_mappings = {
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm {
      select = true,
    },
    ['<CR>'] = cmp.mapping.confirm {
      select = true,
    },
    ['<C-Space>'] = cmp.mapping.complete(),
  }

  cmp.setup {
    mapping = cmp_mappings,
    sources = {
      {
        name = 'copilot',
      },
      {
        name = 'nvim_lsp',
      },
      {
        name = 'luasnip',
      },
      {
        name = 'nvim_lua',
      },
      {
        name = 'buffer',
      },
      {
        name = 'path',
      },
      {
        name = 'treesitter',
      },
      {
        name = 'spell',
      },
      {
        name = 'cmdline',
      },
    },
    window = {
      completion = {
        border = 'rounded',
        scrollbar = true,
      },
      documentation = {
        border = 'rounded',
      },
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
  }

  -- Set up cmdline completion
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { {
      name = 'buffer',
    } },
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
      { {
        name = 'path',
      } },
      { {
        name = 'cmdline',
        option = {
          ignore_cmds = { 'Man', '!' },
        },
      } }
    ),
  })
end

return setup

