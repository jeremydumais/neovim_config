require("lint").linters_by_ft = {
   c = { "cpplint" },
   cpp = { "cpplint", "cppcheck" },
   go = { "revive", "staticcheck", "golangcilint" },
   lua = { "luacheck" }
}

local cpplint = require('lint').linters.cpplint
cpplint.args = {
  '--filter=-whitespace/line_length,-build/include_subdir,-legal/copyright',
}

local clangtidy = require('lint').linters.clangtidy
clangtidy.args = {
  '-p build'
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end
})
