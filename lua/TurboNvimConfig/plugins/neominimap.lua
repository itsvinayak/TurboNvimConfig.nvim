local setup = {
  'Isrothy/neominimap.nvim',
  enabled = true,
  lazy = false, -- NOTE: NO NEED to Lazy load
  -- Optional
  keys = {
    { '<leader>nm', '<cmd>Neominimap toggle<cr>', desc = 'Toggle minimap' },
    { '<leader>no', '<cmd>Neominimap toggleFocus<cr>', desc = 'Toggle focus on minimap' },
    { '<leader>nwt', '<cmd>Neominimap winToggle<cr>', desc = 'Toggle minimap for current window' },
    { '<leader>nwr', '<cmd>Neominimap winRefresh<cr>', desc = 'Refresh minimap for current window' },
    { '<leader>nbt', '<cmd>Neominimap bufToggle<cr>', desc = 'Toggle minimap for current buffer' },
  },
  init = function()
    vim.opt.wrap = false -- Recommended
    vim.opt.sidescrolloff = 36 -- It's recommended to set a large value
    vim.g.neominimap = {
      auto_enable = false,
      minimap_width = 10, ---@type integer,
      click = {
        -- Enable mouse click on minimap
        enabled = true, ---@type boolean
        -- Automatically switch focus to minimap when clicked
        auto_switch_focus = true, ---@type boolean
      },
    }
  end,
}

return setup
