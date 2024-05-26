-- dap.lua
local dap = require('dap')
local dapui = require('dapui')

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/path/to/OpenDebugAD7',  -- Replace this with the actual path to OpenDebugAD7
  options = {
    detached = false
  }
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    setupCommands = {
      {
        description = 'Enable pretty-printing for gdb',
        text = '-enable-pretty-printing',
        ignoreFailures = false
      },
    },
    args = {},
    env = function()
      local variables = {}
      for k, v in pairs(vim.fn.environ()) do
        table.insert(variables, string.format("%s=%s", k, v))
      end
      return variables
    end,
    externalConsole = true,
    MIMode = 'gdb',
    miDebuggerPath = '/usr/bin/gdb',  -- Ensure this path is correct
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'Enable pretty-printing',
        ignoreFailures = false
      },
    },
  },
}

-- Optional UI for nvim-dap
dapui.setup()
vim.keymap.set('n', '<F5>', function() dap.continue() end)
vim.keymap.set('n', '<F10>', function() dap.step_over() end)
vim.keymap.set('n', '<F11>', function() dap.step_into() end)
vim.keymap.set('n', '<F12>', function() dap.step_out() end)
vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
vim.keymap.set('n', '<leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end)
vim.keymap.set('n', '<leader>dl', function() dap.run_last() end)

-- Custom command for compiling and running C++ code
vim.api.nvim_exec([[
command! -nargs=0 RunCpp !g++ -std=c++17 % -o %:r && ./%:r < input.txt > output.txt
]], false)

