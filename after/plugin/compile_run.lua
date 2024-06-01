-- after/plugin/compile_run.lua

-- Define the CompileCpp command
vim.api.nvim_exec([[
command! CompileCpp execute "silent !g++ -std=c++17 % -o %:r"
]], false)

-- Define the RunCpp command
vim.api.nvim_exec([[
command! RunCpp execute "silent !g++ -std=c++17 % -o %:r && %:r < input.txt > output.txt"
]], false)

-- Key mappings for CompileCpp and RunCpp commands
vim.api.nvim_set_keymap('n', '<leader>cc', ':CompileCpp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rc', ':RunCpp<CR>', { noremap = true, silent = true })

