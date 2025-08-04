-- Testing Configuration
-- Handles testing frameworks and debugging tools

if nixCats('testing') then
  vim.cmd('packadd neotest')
  vim.cmd('packadd neotest-python')
  vim.cmd('packadd nvim-dap')
  vim.cmd('packadd nvim-dap-ui')
  vim.cmd('packadd nvim-dap-go')
end

-- Neotest configuration
if nixCats('testing') then
  require('neotest').setup {
    adapters = {
      require('neotest-python') {
        dap = { justMyCode = false },
        args = { '--log-level', 'DEBUG' },
        runner = 'pytest',
        python = '.venv/bin/python',
      },
    },
  }
  
  -- Neotest keymaps
  vim.keymap.set('n', '<leader>tt', function()
    require('neotest').run.run()
  end, { desc = 'Run nearest test' })
  
  vim.keymap.set('n', '<leader>tf', function()
    require('neotest').run.run(vim.fn.expand('%'))
  end, { desc = 'Run current file tests' })
  
  vim.keymap.set('n', '<leader>td', function()
    require('neotest').run.run({ strategy = 'dap' })
  end, { desc = 'Debug nearest test' })
  
  vim.keymap.set('n', '<leader>ts', function()
    require('neotest').summary.toggle()
  end, { desc = 'Toggle test summary' })
  
  vim.keymap.set('n', '<leader>to', function()
    require('neotest').output.open({ enter = true })
  end, { desc = 'Open test output' })
  
  vim.keymap.set('n', '<leader>tO', function()
    require('neotest').output_panel.toggle()
  end, { desc = 'Toggle test output panel' })
  
  vim.keymap.set('n', '<leader>tS', function()
    require('neotest').run.stop()
  end, { desc = 'Stop test' })
end

-- DAP (Debug Adapter Protocol) configuration
if nixCats('testing') then
  local dap = require('dap')
  local dapui = require('dapui')
  
  -- DAP UI setup
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
  
  -- Auto open/close DAP UI
  dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
  end
  
  -- DAP keymaps
  vim.keymap.set('n', '<F5>', function()
    dap.continue()
  end, { desc = 'Debug: Start/Continue' })
  
  vim.keymap.set('n', '<F1>', function()
    dap.step_into()
  end, { desc = 'Debug: Step Into' })
  
  vim.keymap.set('n', '<F2>', function()
    dap.step_over()
  end, { desc = 'Debug: Step Over' })
  
  vim.keymap.set('n', '<F3>', function()
    dap.step_out()
  end, { desc = 'Debug: Step Out' })
  
  vim.keymap.set('n', '<leader>db', function()
    dap.toggle_breakpoint()
  end, { desc = 'Debug: Toggle Breakpoint' })
  
  vim.keymap.set('n', '<leader>dB', function()
    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  end, { desc = 'Debug: Set Breakpoint' })
  
  vim.keymap.set('n', '<F7>', function()
    dapui.toggle()
  end, { desc = 'Debug: See last session result.' })
end

-- DAP Go configuration
if nixCats('testing') and nixCats('go') then
  require('dap-go').setup()
  
  -- Go-specific test keymaps
  vim.keymap.set('n', '<leader>dgt', function()
    require('dap-go').debug_test()
  end, { desc = 'Debug Go test' })
  
  vim.keymap.set('n', '<leader>dgl', function()
    require('dap-go').debug_last_test()
  end, { desc = 'Debug last Go test' })
end