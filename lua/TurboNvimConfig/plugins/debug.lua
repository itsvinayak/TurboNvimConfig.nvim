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

  require('nvim-dap-virtual-text').setup {
    enabled = true, -- enable this plugin (the default)
    enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true, -- show stop reason when stopped for exceptions
    commented = false, -- prefix virtual text with comment string
    only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
    all_references = false, -- show virtual text on all all references of the variable (not only definitions)
    filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
    -- Experimental Features:
    virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
  }

  -- colors for virtual text
  vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
  vim.api.nvim_set_hl(0, 'DapLogPointSign', { default = true, link = 'Comment' })
  vim.api.nvim_set_hl(0, 'DapBreakpointSign', { default = true, link = 'Error' })

  -- Enable virtual text
  vim.g.dap_virtual_text = true

  vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapStopped', { text = '⭐️', texthl = '', linehl = '', numhl = '' })

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
      -- run node .
      run_node_dot = function(config)
        local js_mason_path = os.getenv 'HOME' .. '.local/share/nvim/mason/packages/node-debug2-adapter'
        config.adapters = {
          type = 'executable',
          command = 'node-debug2-adapter',
          args = {
            '--node',
            js_mason_path .. '/node_modules/vscode-node-debug2/out/src/nodeDebug.js',
            '--',
            '.',
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
    icons = { expanded = ' ▾ ', collapsed = ' ▸ ', current_frame = ' * ' },
    controls = {
      icons = {
        pause = ' ⏸ ',
        play = ' ▶ ',
        step_into = ' ⏎ ',
        step_over = ' ⏭ ',
        step_out = ' ⏮ ',
        step_back = ' b ',
        run_last = ' ▶▶ ',
        terminate = ' ⏹ ',
        disconnect = ' ⏏ ',
      },
    },
  }

  vim.keymap.set('n', 'dui', dapui.toggle, { desc = 'Debug: Toggle UI' })

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close
end

return setup
