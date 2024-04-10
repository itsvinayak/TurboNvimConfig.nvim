return {
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', '<cmd>Telescope undo<CR>', {
        desc = 'Telescope Undo',
      })
    end,
  },
}
