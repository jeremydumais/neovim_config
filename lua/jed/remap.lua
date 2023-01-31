vim.g.mapleader = "_"

vim.keymap.set("x", "<leader>p", [["_dP]])

--vim.keymap.set("n", "<C-e>", "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>")
vim.keymap.set("n", "<C-e>", "<cmd>bd<cr>")
vim.keymap.set("n", "<C-a>", "ggVG")
vim.keymap.set("v", "<C-J>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-K>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<F17>", "<cmd>lua require('jed.utils').run()<CR>")
vim.keymap.set("n", "<F21>", "<cmd>lua require('jed.utils').test()<CR>")
vim.keymap.set("n", "<A-b>", "<cmd>lua require('jed.utils').build()<CR>")
vim.keymap.set("n", "<Leader>co", "<cmd>lua require('jed.utils').coverage()<CR>")

vim.keymap.set("i", '"', '""<left>')
vim.keymap.set("i", "'", "''<left>")
vim.keymap.set("i", "(", "()<left>")
vim.keymap.set("i", "[", "[]<left>")
vim.keymap.set("i", "{", "{}<left>")
vim.keymap.set("i", "{<CR>", "{<CR>}<ESC>O")

