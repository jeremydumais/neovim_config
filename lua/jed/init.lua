require("jed.remap")
require("jed.packer")
require("jed.set")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local JedGroup = vim.api.nvim_create_augroup("Jed", {})

vim.api.nvim_create_autocmd({"BufWritePre"}, {
    group = JedGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_user_command('W', 'w', {})

vim.api.nvim_create_user_command("SetProject", function(opts)
    require('jed.utils').set_project(opts.args) end, {})

vim.api.nvim_create_user_command("ClearProject", function()
    require('jed.utils').clear_project() end, {})

