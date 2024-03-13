-- Import required modules
local lspconfig = require("lspconfig")
local cmp = require("cmp")
local lsp_zero = require("lsp-zero")

-- Define the setup function
local setup = function()
    -- Configure LSP
    lsp_zero.preset("recommended")

    lspconfig.lua_ls.setup({
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    globals = { 'vim' },
                },
            },
        },
    })

    -- Ensure installation of multiple language servers
    lsp_zero.ensure_installed({
        'tsserver',
        'rust_analyzer',
        'lua_ls',
        'eslint',
        'dockerls',
        'marksman',
        'html',
        'jsonls'
    })

    -- Set LSP keybindings
    lsp_zero.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        local keymap = vim.keymap
        local diagnostic = vim.diagnostic
        keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        keymap.set("n", "<leader>vd", function() diagnostic.setloclist() end, opts)
        keymap.set("n", "[d", function() diagnostic.goto_next() end, opts)
        keymap.set("n", "]d", function() diagnostic.goto_prev() end, opts)
        keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end)

    -- Set up nvim-cmp
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    local cmp_mappings = {
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }

    cmp.setup({
        mapping = cmp_mappings,
        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip', keyword_length = 2 },
            { name = 'buffer',  keyword_length = 3 },
            { name = 'path' },
            { name = 'copilot' }
        },
    })

    -- Set up cmdline completion
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            {
                name = 'cmdline',
                option = {
                    ignore_cmds = { 'Man', '!' }
                }
            }
        })
    })
end


setup()

return {}
