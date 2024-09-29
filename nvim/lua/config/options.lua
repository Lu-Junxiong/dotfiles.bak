local opt = vim.opt
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = true
opt.autoindent = true
opt.cursorline = true
opt.scrolloff = 4

opt.number = true
opt.relativenumber = true
opt.numberwidth = 2

-- [[ Search ]]
opt.incsearch = true
-- Case insensitive searching unless /C or capitilization is used in search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

opt.termguicolors = true
opt.colorcolumn = "100"
opt.encoding = "UTF-8"
opt.clipboard:append("unnamedplus")
opt.swapfile = false
opt.backup = false
opt.mouse:append("a")
vim.o.foldlevel = 99
vim.o.foldcolumn = '1'
vim.wo.foldnestmax = 3
vim.wo.foldminlines = 1
vim.o.foldenable = true
vim.o.foldlevelstart = 99
vim.o.foldtext =
[[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').' ... ' . '(' . (v:foldend - v:foldstart + 1) . ' lines)']]
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
