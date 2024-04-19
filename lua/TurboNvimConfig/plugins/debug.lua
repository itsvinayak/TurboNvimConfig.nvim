-- debug.lua
local setup = {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    -- nio https://github.com/nvim-neotest/nvim-nio
    'nvim-neotest/nvim-nio',
    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
}

function setup.config()
  local dap = require 'dap'
  local dapui = require 'dapui'

  -- colors for virtual text
  vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
  vim.api.nvim_set_hl(0, 'DapLogPointSign', { default = true, link = 'Comment' })
  vim.api.nvim_set_hl(0, 'DapBreakpointSign', { default = true, link = 'Error' })

  require('mason-nvim-dap').setup {
    automatic_setup = true,
    handlers = {
      function(config)
        require('mason-nvim-dap').default_setup(config)
      end,
      -- your dap setup
      -- python
      python = function(config)
        config.adapters = {
          type = 'executable',
          command = '/usr/bin/python3',
          args = {
            '-m',
            'debugpy.adapter',
          },
        }
        require('mason-nvim-dap').default_setup(config) -- don't forget this!
      end,
      -- node2
      node2 = function(config)
        local js_mason_path = os.getenv 'HOME' .. '.local/share/nvim/mason/packages/node-debug2-adapter'
        config.adapters = {
          type = 'executable',
          command = 'node-debug2-adapter',
          args = {
            '--node',
            js_mason_path .. '/node_modules/vscode-node-debug2/out/src/nodeDebug.js',
          },
        }
        require('mason-nvim-dap').default_setup(config) -- don't forget this!
      end,
    },
    ensure_installed = {
      'python',
      'node2',
      'chrome',
      'js',
    },
  }

  -- Basic debugging keymaps, feel free to change to your liking!
  vim.keymap.set('n', 'dsc', dap.continue, { desc = 'Debug: Start/Continue' })
  vim.keymap.set('n', 'dsi', dap.step_into, { desc = 'Debug: Step Into' })
  vim.keymap.set('n', 'ds', dap.step_over, { desc = 'Debug: Step Over' })
  vim.keymap.set('n', 'dso', dap.step_out, { desc = 'Debug: Step Out' })
  vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
  vim.keymap.set('n', '<leader>B', function()
    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  end, { desc = 'Debug: Set Breakpoint' })

  -- Dap UI setup
  -- For more information, see |:help nvim-dap-ui|
  dapui.setup {
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    controls = {
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
      },
    },
  }

  vim.keymap.set('n', 'dui', dapui.toggle, { desc = 'Debug: See last session result.' })

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close
end

return setup
