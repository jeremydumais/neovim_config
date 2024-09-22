local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
  'rust_analyzer',
  'clangd',
  'eslint',
  'lua_ls',
  'intelephense',
  'powershell_es'
})

lsp.configure('lua_ls', {
  cmd = { 'lua-language-server' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

lsp.on_attach(function(client, bufnr)
  vim.g.opts = {buffer = bufnr, remap = false}
end)

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<cr>'] = cmp.mapping.confirm({select = true}),
    })
})


--local cmp_select = {behavior = cmp.SelectBehavior.Select}
--local cmp_mappings = lsp.defaults.cmp_mappings({
  --['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  --['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  --['<C-y>'] = cmp.mapping.confirm({ select = true }),
  --["<C-Space>"] = cmp.mapping.complete(),
--})

--lsp.setup_nvim_cmp({
  --mapping = cmp_mappings
--})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
})

vim.g.diagnostics_active = true
function _G.toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.lsp.diagnostic.clear(0)
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
  else
    vim.g.diagnostics_active = true
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      }
    )
  end
end

vim.api.nvim_set_keymap('n', '<leader>tt', ':call v:lua.toggle_diagnostics()<CR>',  {noremap = true, silent = true})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.g.opts)
vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.g.opts)
vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, vim.g.opts)
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, vim.g.opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_next, vim.g.opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, vim.g.opts)
vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, vim.g.opts)
vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, vim.g.opts)
vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, vim.g.opts)
vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, vim.g.opts)

local bundle_path = '/home/jed/Programming/powershell-editor-services'

require('lspconfig')['powershell_es'].setup {
	bundle_path = bundle_path,
	--on_attach = on_attach
}
