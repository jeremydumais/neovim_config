-- NOTE: to make any of this work you need a language server.
-- If you don't know what that is, watch this 5 min video:
-- https://www.youtube.com/watch?v=LaS32vctfOY

-- Reserve a space in the gutter
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set("n", "<leader>vd", '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

-- You'll find a list of language servers here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
-- These are example language servers.
require('lspconfig').clangd.setup({})
require('lspconfig').rust_analyzer.setup({})
require('lspconfig').clangd.setup({})
require('lspconfig').eslint.setup({})
require('lspconfig').lua_ls.setup({})
require('lspconfig').intelephense.setup({})
require('lspconfig').powershell_es.setup({})

local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
  mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
  --mapping = cmp.mapping.preset.insert({}),
})









--local lsp = require('lsp-zero')
--lsp.preset('recommended')

--lsp.ensure_installed({
--'rust_analyzer',
--'clangd',
--'eslint',
--'lua_ls',
--'intelephense',
--'powershell_es'
--})

--lsp.configure('lua_ls', {
--cmd = { 'lua-language-server' },
--settings = {
--Lua = {
  --runtime = {
    --version = 'LuaJIT',
    --path = vim.split(package.path, ';'),
  --},
  --diagnostics = {
    --globals = { 'vim' },
  --},
--},
--},
--})

--lsp.on_attach(function(client, bufnr)
--vim.g.opts = {buffer = bufnr, remap = false}
--end)

--local cmp = require('cmp')
--local cmp_action = require('lsp-zero').cmp_action()

--cmp.setup({
--window = {
    --completion = cmp.config.window.bordered(),
    --documentation = cmp.config.window.bordered(),
--},
--mapping = cmp.mapping.preset.insert({
    --['<C-Space>'] = cmp.mapping.complete(),
    --['<C-f>'] = cmp_action.luasnip_jump_forward(),
    --['<C-b>'] = cmp_action.luasnip_jump_backward(),
    --['<C-u>'] = cmp.mapping.scroll_docs(-4),
    --['<C-d>'] = cmp.mapping.scroll_docs(4),
    --['<cr>'] = cmp.mapping.confirm({select = true}),
--})
--})


----local cmp_select = {behavior = cmp.SelectBehavior.Select}
----local cmp_mappings = lsp.defaults.cmp_mappings({
----['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
----['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
----['<C-y>'] = cmp.mapping.confirm({ select = true }),
----["<C-Space>"] = cmp.mapping.complete(),
----})

----lsp.setup_nvim_cmp({
----mapping = cmp_mappings
----})

--lsp.setup()

vim.diagnostic.config({
virtual_text = true,
signs = true,
underline = true,
update_in_insert = false,
})

--vim.g.diagnostics_active = true
--function _G.toggle_diagnostics()
--if vim.g.diagnostics_active then
--vim.g.diagnostics_active = false
--vim.lsp.diagnostic.clear(0)
--vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
--else
--vim.g.diagnostics_active = true
--vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  --vim.lsp.diagnostic.on_publish_diagnostics, {
    --virtual_text = true,
    --signs = true,
    --underline = true,
    --update_in_insert = false,
  --}
--)
--end
--end

--vim.api.nvim_set_keymap('n', '<leader>tt', ':call v:lua.toggle_diagnostics()<CR>',  {noremap = true, silent = true})
--vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.g.opts)
--vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.g.opts)
--vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, vim.g.opts)
--vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, vim.g.opts)
--vim.keymap.set("n", "[d", vim.diagnostic.goto_next, vim.g.opts)
--vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, vim.g.opts)
--vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, vim.g.opts)
--vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, vim.g.opts)
--vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, vim.g.opts)
--vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, vim.g.opts)

--local bundle_path = '/home/jed/Programming/powershell-editor-services'

--require('lspconfig')['powershell_es'].setup {
--bundle_path = bundle_path,
----on_attach = on_attach
--}
