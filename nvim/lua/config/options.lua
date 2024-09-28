local opt = vim.opt
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
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
