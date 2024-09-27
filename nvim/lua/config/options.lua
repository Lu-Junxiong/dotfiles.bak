local opt = vim.opt 
--pt.termguicolors = true
opt.relativenumber = true 
opt.number = true
opt.autoindent = true
opt.cursorline = true
opt.clipboard:append("unnamedplus")
opt.ignorecase = true
opt.smartcase = true
opt.wrap = true
opt.incsearch = true
opt.tabstop = 4
opt.shiftround = true
opt.shiftwidth = 4
opt.scrolloff = 4
opt.termguicolors = true
if vim.g.neovide then
    vim.opt.guifont = {"JetBrainsMono Nerd Font Mono", ":h14"}
end
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
