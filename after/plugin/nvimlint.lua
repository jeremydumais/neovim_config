require("lint").linters_by_ft = {
   cpp = { "cpplint", "clangtidy" },
   go = { "revive", "staticcheck", "golangcilint" },
   lua = { "luacheck" }
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end
})
