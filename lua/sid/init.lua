require("sid.remap")
require("sid.set") 

-- Function to enable GitHub Copilot
function EnableCopilot()
  vim.cmd("Copilot enable")
end

-- Function to disable GitHub Copilot
function DisableCopilot()
  vim.cmd("Copilot disable")
end

-- Command to enable Copilot
vim.api.nvim_command('command! EnableCopilot lua EnableCopilot()')

-- Command to disable Copilot
vim.api.nvim_command('command! DisableCopilot lua DisableCopilot()')

-- Key mappings for enabling and disabling Copilot
vim.api.nvim_set_keymap('n', '<leader>ce', ':EnableCopilot<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cd', ':DisableCopilot<CR>', { noremap = true, silent = true })

