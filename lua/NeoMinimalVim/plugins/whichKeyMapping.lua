local wk = require("which-key")
-- As an example, we will create the following mappings:
--  * <leader>ff find files
--  * <leader>fr show recent files
--  * <leader>fb Foobar
-- we'll document:
--  * <leader>fn new file
--  * <leader>fe edit file
-- and hide <leader>1

wk.register({
    f = {
        name = "file", -- optional group name
        f = {"<cmd>Telescope find_files<cr>", "Find File"}, -- create a binding with label
        r = {
            "<cmd>Telescope oldfiles<cr>",
            "Open Recent File",
            noremap = false,
            buffer = 123
        }, -- additional options for creating the keymap
        n = {"New File"}, -- just a label. don't create any mapping
        e = "Edit File", -- same as above
        ["1"] = "which_key_ignore", -- special label to hide it in the popup
        b = {function()
            print("bar")
        end, "Foobar"} -- you can also pass functions!
    }
}, {
    prefix = "<leader>"
})

-- undo tree <leader>u
wk.register({
    f = {
        name = "undo tree",
        u = {"<cmd>Telescope undo<cr>", "Telescope Undo"}
    }
}, {
    prefix = "<leader>"
})

-- neo tree <leader>nt
wk.register({
    f = {
        name = "file tree",
        nt = {"<cmd>Neotree toggle<cr>", "Toggle Neotree"}
    }
}, {
    prefix = "<leader>"
})

wk.register({
    f = {
        name = "fold",
        z = {
            name = "fold",
            R = {"<cmd>lua require('ufo').openAllFolds()<cr>", "Open All Folds"},
            M = {"<cmd>lua require('ufo').closeAllFolds()<cr>", "Close All Folds"},
            K = {function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then
                    vim.lsp.buf.hover()
                end
            end, "Peek Fold"}
        },
        o = {"<cmd>foldopen<cr>", "Fold Open"},
        c = {"<cmd>foldclose<cr>", "Fold Close"}
    }
}, {
    prefix = "<leader>"
})
