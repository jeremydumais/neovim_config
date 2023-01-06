vim.g.mapleader = "_"
vim.keymap.set("n", "<C-e>", "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>")
vim.keymap.set("n", "<C-a>", "ggVG")
vim.keymap.set("v", "<C-J>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-K>", ":m '<-2<CR>gv=gv")
