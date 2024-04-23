return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'InsertEnter',
    config = function()
      local configs = require 'nvim-treesitter.configs'

      configs.setup {
        ensure_installed = {
          'javascript',
          'typescript',
          'python',
          'c',
          'lua',
          'vim',
          'dockerfile',
          'json',
          'tsx',
          'bash',
        },
        sync_install = true,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            scope_incremental = '<C-CR>',
            node_decremental = '<bs>',
          },
        },
      }
    end,
  },
}
