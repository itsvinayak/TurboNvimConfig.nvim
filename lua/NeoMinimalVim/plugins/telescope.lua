return {{
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = {"nvim-lua/plenary.nvim", "joshmedeski/telescope-smart-goto.nvim"}
}, {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make"
}, {
    "exosyphon/telescope-color-picker.nvim",
    config = function()
        vim.keymap.set("n", "<leader>uC", "<cmd>Telescope colors<CR>", {
            desc = "Telescope Color Picker"
        })
    end
}, {"nvim-telescope/telescope-ui-select.nvim"}, {"debugloop/telescope-undo.nvim"},
        {"nvim-telescope/telescope-live-grep-args.nvim"}, {"nanotee/zoxide.vim"}, {
    "aaronhallaert/advanced-git-search.nvim",
    dependencies = {"nvim-telescope/telescope.nvim", "tpope/vim-fugitive", "tpope/vim-rhubarb"}
}}
