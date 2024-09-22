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

vim.api.nvim_create_user_command("SetExecutable", function(opts)
    require('jed.utils').set_executable(opts.args) end, {})

vim.api.nvim_create_user_command("SetArgs", function(opts)
    require('jed.utils').set_args(vim.split(opts.args, " "))
end,
{nargs = "*", desc = "Set arguments for the SetArgs command"})

vim.api.nvim_create_user_command("ClearArgs", function()
    require('jed.utils').clear_args() end, {})
