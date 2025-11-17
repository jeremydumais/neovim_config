local M = {}
vim.g.mapleader = "_"

vim.keymap.set("n", "<leader>p", "<cmd>Telescope yank_history<CR>", { desc = "Paste from yank history" })
vim.keymap.set("x", "<leader>p", function()
 -- delete selection into the black hole
  vim.cmd([[normal! "_d]])

  -- open yank history, override the default action
  require("telescope").extensions.yank_history.yank_history({
    attach_mappings = function(_, map)
      local actions = require("yanky.telescope.mapping")
      -- replace the default enter action with "put before"
      map("i", "<CR>", actions.put("P"))  -- 'p' = put before in Yanky’s API
      map("n", "<CR>", actions.put("P"))
      return true
    end,
  })
end, { desc = "Replace selection from yank history (paste before)" })

--Replace word in all the file
vim.keymap.set("n", "<leader>rw", "yiwggVG:s/<C-R><C-\">")
--Save current file
vim.keymap.set("i", "<C-s>", "<cmd>w<CR><ESC>")
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>")

--vim.keymap.set("n", "<C-e>", "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>")
vim.keymap.set("n", "<C-e>", "<cmd>bp|bd #<cr>")
vim.keymap.set("v", "<C-e>", "<cmd>bp|bd #<cr>")
vim.keymap.set("n", "<C-a>", "ggVG")
vim.keymap.set("v", "<C-J>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-K>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<A-2>", "<C-W>-")
vim.keymap.set("n", "<A-4>", "<C-W><")
vim.keymap.set("n", "<A-6>", "<C-W>>")
vim.keymap.set("n", "<A-8>", "<C-W>+")

vim.keymap.set("n", "<F17>", "<cmd>lua require('jed.utils').run()<CR>")
vim.keymap.set("n", "<S-F5>", "<cmd>lua require('jed.utils').run()<CR>")
vim.keymap.set("n", "<F21>", "<cmd>lua require('jed.utils').test()<CR>")
vim.keymap.set("n", "<S-F9>", "<cmd>lua require('jed.utils').test()<CR>")
vim.keymap.set("n", "<A-b>", "<cmd>lua require('jed.utils').build()<CR>")
vim.keymap.set("n", "<Leader>co", "<cmd>lua require('jed.utils').coverage()<CR>")

vim.keymap.set("i", '"', '""<left>')
vim.keymap.set("i", "'", "''<left>")
-- disable in markdown and text
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text" },
  callback = function()
    pcall(vim.keymap.del, "i", "'")
  end,
})
vim.keymap.set("i", "(", "()<left>")
vim.keymap.set("i", "[", "[]<left>")
vim.keymap.set("i", "{", "{}<left>")
vim.keymap.set("i", "{<CR>", "{<CR>}<ESC>O")

vim.keymap.set("n", "<leader>t", ":term<CR>i")
vim.keymap.set("n", "<leader>f", ":Telescope grep_string<CR>")
vim.keymap.set("v", "<leader>f", ":Telescope grep_string<CR>")

function M.searchFunction()
    require('telescope.builtin').lsp_document_symbols({
    symbols = {'method', 'function'},
    symbol_width = 56
})
end
vim.keymap.set("n", "<leader>fp", M.searchFunction)
vim.keymap.set("v", "<leader>fp", M.searchFunction)
