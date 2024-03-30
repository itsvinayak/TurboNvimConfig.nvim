local setup = {
  'VonHeikemen/lsp-zero.nvim',
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

local function wkSetup()
  local wk = require 'which-key'
  wk.register {
    ['<leader>la'] = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action' },
    ['<leader>lf'] = {
      "<cmd>lua vim.lsp.buf.format({async = true, filter = function(client) return client.name ~= 'typescript-tools' end})<cr>",
      'Format',
    },
    ['<leader>li'] = { '<cmd>LspInfo<cr>', 'Info' },
    ['<leader>lj'] = { '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Next Diagnostic' },
    ['<leader>lh'] = { "<cmd>lua require('user.lspconfig').toggle_inlay_hints()<cr>", 'Hints' },
    ['<leader>lk'] = { '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Prev Diagnostic' },
    ['<leader>ll'] = { '<cmd>lua vim.lsp.codelens.run()<cr>', 'CodeLens Action' },
    ['<leader>lq'] = { '<cmd>lua vim.diagnostic.setloclist()<cr>', 'Quickfix' },
    ['<leader>lr'] = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' },
  }

  wk.register {
    ['<leader>la'] = {
      name = 'LSP',
      a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action', mode = 'v' },
    },
  }
end

local function lsp_keyMapping(bufnr)
  local opts = { noremap = true, silent = true }

  local keymap = vim.api.nvim_buf_set_keymap

  keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  keymap(bufnr, 'n', '<leader>ws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
  keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  keymap(bufnr, 'n', '<leader>vd', '<cmd>lua vim.lsp.diagnostic.setloclist()<CR>', opts)
  keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  keymap(bufnr, 'n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
end

function setup.config()
  local mason = require 'mason'
  local mason_lspconfig = require 'mason-lspconfig'
  local cmp = require 'cmp'
  local lsp_zero = require 'lsp-zero'
  local luasnip = require 'luasnip'

  wkSetup()
  -- highting for LSP diagnostics
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
  mason.setup {}
  mason_lspconfig.setup {
    ensure_installed = { 'tsserver', 'rust_analyzer', 'lua_ls' },
    handlers = {
      lsp_zero.default_setup,
    },
  }

  require('lspconfig.ui.windows').default_options.border = 'rounded'

  -- nvim diagnostic config
  local default_diagnostic_config = {
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  }

  vim.diagnostic.config(default_diagnostic_config)

  for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), 'signs', 'values') or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

  -- Set LSP keybindings
  lsp_zero.on_attach(function(client, bufnr)
    lsp_keyMapping(bufnr)
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
