-- return { {
--     "neanias/everforest-nvim",
--     config = function()
--         require('everforest').setup({
--             background = "medium",
--             transparent_background = false,
--             italics = true
--         })
--         vim.cmd("colorscheme everforest")
--         vim.o.background = "light"
--     end,
--     opts = {
--         event = "VimEnter"
--     }
-- } }
-- return {{
--     "lunarvim/Onedarker.nvim",
--     config = function()
--         require('onedarker').setup({})
--         vim.cmd("colorscheme onedarker")
--         vim.o.background = "dark"
--     end
-- }}
return { {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require('catppuccin').setup({
            flavour = "frappe", 
        })
        vim.cmd("colorscheme catppuccin")
        vim.api.nvim_set_hl(0, "Pmenu", { bg = "#502327", fg = "#127ae6" })
        vim.o.background = "dark"
    end
} }
-- return {
--     {
--         "folke/tokyonight.nvim",
--         lazy = false,
--         priority = 1000,
--         opts = {},
--         config = function()
--             require('tokyonight').setup({
--             })
--             vim.cmd("colorscheme tokyonight")
--             vim.o.background = "light"
--         end
--       },
-- }
-- return {{
--     "ellisonleao/gruvbox.nvim",
--     priority = 1000,
--     config = function()
--         require('gruvbox').setup({})
--         vim.cmd("colorscheme gruvbox")
--         vim.o.background = "dark"
--     end
-- }}
-- return {
--     "rebelot/kanagawa.nvim",
--     config = function()
--         require('kanagawa').setup({
--         })
--         vim.cmd("colorscheme kanagawa")
--         vim.api.nvim_set_hl(0, "Pmenu", { bg = "#502327", fg = "#127ae6" })
--         vim.o.background = "dark"
--     end
-- }