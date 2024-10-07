-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({{"Failed to clone lazy.nvim:\n", "ErrorMsg"}, {out, "WarningMsg"},
                           {"\nPress any key to exit..."}}, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
    spec = {{
        import = "plugins"
    }, 
},
    install = {
        missing = true,
        colorscheme = {"catppuccin"}
    },
    defaults = {
        lazy = false,
        version = false,
        cond = nil
    },
    pkg = {
        enabled = true,
        cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua",
        versions = true,
        sources = {"lazy"}
    },
    ui = {
        -- a number <1 is a percentage., >1 is a fixed size
        size = {
            width = 0.6,
            height = 0.6
        },
        wrap = true, -- wrap the lines in the ui
        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = "double",
        -- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
        backdrop = 50,
        title = "Lazy",
        title_pos = "center",
        pills = true
    },
    change_detection = {
        enabled = true,
        notify = true
    },
    
})
