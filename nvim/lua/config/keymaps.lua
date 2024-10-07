-- 设置空格为 leader 键
vim.g.mapleader = " "
local keymap = vim.keymap

-- 插入模式下输入 'jk' 退出到普通模式
keymap.set("i", "jk", "<ESC>")

-- 在可视模式下移动选中的行
keymap.set("v", "<C-j>", [[:m '>+1<CR>gv=gv]]) -- 向下移动
keymap.set("v", "<C-k>", [[:m '<-2<CR>gv=gv]]) -- 向上移动

-- 取消高亮搜索
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- 格式化当前缓冲区的代码
keymap.set({ "n", "v" }, "<leader>lf", vim.lsp.buf.format, { remap = false })

-- 自定义命令 WQA：保存所有缓冲区并关闭
vim.cmd([[
command! WQA execute 'write | %bwipeout!' | silent! tabonly | Dashboard
]])

vim.keymap.set('n', '<leader><CR>', ':WQA<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>w', ':wa<CR>', { noremap = true, silent = true })

-- 使用 Alt + 方向键移动窗口
keymap.set({'n', 't'}, '<A-h>', [[<C-\><C-n><Cmd>wincmd h<CR>]]) -- 移动到左窗口
keymap.set({'n', 't'}, '<A-j>', [[<C-\><C-n><Cmd>wincmd j<CR>]]) -- 移动到下窗口
keymap.set({'n', 't'}, '<A-k>', [[<C-\><C-n><Cmd>wincmd k<CR>]]) -- 移动到上窗口
keymap.set({'n', 't'}, '<A-l>', [[<C-\><C-n><Cmd>wincmd l<CR>]]) -- 移动到右窗口
keymap.set("n", "<leader>ss", ":split<CR><C-w>w")
keymap.set("n", "<leader>sv", ":vsplit<CR><C-w>w")
keymap.set("n", "<leader>q", "<C-w>q")
keymap.set("n", "q", ":bd<CR>")
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>dt", ":windo diffthis<CR>", { desc = "Enable diff in all windows" })
vim.keymap.set("n", "<leader>do", ":windo diffoff<CR>", { desc = "Disable diff in all windows" })
