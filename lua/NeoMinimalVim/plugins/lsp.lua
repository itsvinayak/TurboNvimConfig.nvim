return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
          -- LSP Support
          { "neovim/nvim-lspconfig" }, -- Required
          { "zbirenbaum/copilot-cmp" },
          { -- Optional
            "williamboman/mason.nvim",
            build = function()
              pcall(vim.cmd, "MasonUpdate")
            end,
          },
          { "williamboman/mason-lspconfig.nvim" }, -- Optional
    
          -- Autocompletion
          { "hrsh7th/nvim-cmp" }, -- Required
          { "hrsh7th/cmp-nvim-lsp" }, -- Required
          { "L3MON4D3/LuaSnip" }, -- Required
          { "rafamadriz/friendly-snippets" },
          { "hrsh7th/cmp-buffer" },
          { "hrsh7th/cmp-path" },
          { "hrsh7th/cmp-cmdline" },
          { "saadparwaiz1/cmp_luasnip" },
        },
      }
}
