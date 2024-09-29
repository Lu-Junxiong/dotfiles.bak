vim.g.mapleader = " "
local keymap = vim.keymap
-- Exit insert mode by typing 'jk'
keymap.set("i", "jk", "<ESC>")
-- move lines in visual mode
keymap.set("v", "<C-j>", [[:m '>+1<CR>gv=gv]])
keymap.set("v", "<C-k>", [[:m '<-2<CR>gv=gv]])
-- cancek highlighting
keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set({"n", "v"}, "<leader>lf", vim.lsp.buf.format, { remap = false })