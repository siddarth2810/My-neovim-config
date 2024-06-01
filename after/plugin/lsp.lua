local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require'lspconfig'.pyright.setup{}
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'tsserver', 'rust_analyzer', 'clangd'},
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
    {name = 'luasnip', keyword_length = 2},
    {name = 'buffer', keyword_length = 3},
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.clangd.setup {
  cmd = {
    'clangd',
    '--header-insertion=never',
    '--compile-commands-dir=/home/siddarth/DSA', -- Ensure this points to your project directory
  },
  capabilities = capabilities,
  filetypes = { "c", "cpp" },
  on_attach = lsp_zero.on_attach,
}

-- Optional: If you don't have a compile_commands.json, you can add flags manually
local clangd_flags = {
  '--header-insertion=never',
  '--query-driver=/usr/bin/clang++,/usr/bin/clang', -- Adjust according to your system
  '--compile-commands-dir=/home/siddarth/DSA', -- Ensure this points to your project directory
  '-I/usr/include/c++/11', -- Adjust according to your compiler version
  '-I/usr/include/x86_64-linux-gnu/c++/11', -- Adjust according to your system
}

-- Make sure to replace the paths with actual paths on your system
lspconfig.clangd.setup {
  cmd = {'clangd', unpack(clangd_flags)},
  capabilities = capabilities,
  on_attach = lsp_zero.on_attach,
  filetypes = { "c", "cpp" },
}

