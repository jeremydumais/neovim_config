require("lint").linters_by_ft = {
   c = { "cpplint" },
   cpp = { "cpplint", "cppcheck", "clangtidy" },
   go = { "revive", "staticcheck", "golangcilint" },
   lua = { "luacheck" },
   javascript = { "eslint" },
   --typescript = { "eslint" },
   --typescriptreact = { "eslint" },
}

local cpplint = require('lint').linters.cpplint
cpplint.args = {
  '--filter=-whitespace/line_length,-build/include_subdir,-legal/copyright',
  '--quiet'
}

local cppcheck = require('lint').linters.cppcheck
cppcheck.args = {
    '--enable=warning,style,performance,portability',
    '-I include',
    '--language=c++',
    '--std=c++20',
    '--template={file}:{line}:{column}: [{id}] {severity}: {message}',
    '--inline-suppr',
    '--quiet'
}

local clangtidy = require('lint').linters.clangtidy
clangtidy.args = {
    '--extra-arg=-Wall',
    '--extra-arg=-Weverything',
    '--extra-arg=-pedantic',
    '--extra-arg=-std=c++20',
    '--extra-arg=-Wdocumentation',
    '--extra-arg=-Wno-c++98-compat',
    '--extra-arg=-Wno-missing-prototypes',
    '--extra-arg=-Wno-old-style-cast', --cpplint provides much more info
    '-p=build',
    '--quiet'
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  callback = function()
    require("lint").try_lint()
  end
})
