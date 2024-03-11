local wk = require("which-key")

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

