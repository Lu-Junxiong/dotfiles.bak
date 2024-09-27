vim.g.mapleader = " "
local keymap = vim.keymap
-- Exit insert mode by typing 'jk'
keymap.set("i", "jk", "<ESC>")
-- fast movement
--keymap.set('n', '<C-l>', '10l')
--keymap.set('n', '<C-j>', '10j')
--keymap.set('n', '<C-h>', '10h')
--keymap.set('n', '<C-k>', '10k')
-- move lines in visual mode
keymap.set("v", "<C-j>", [[:m '>+1<CR>gv=gv]])
keymap.set("v", "<C-k>", [[:m '<-2<CR>gv=gv]])
-- cancek highlighting
keymap.set("n", "<leader>nh", ":nohl<CR>")

