return {{
    "neanias/everforest-nvim",
    config = function()
        require('everforest').setup({
            background = "medium",
            transparent_background = false,
            italics = true
        })
        vim.cmd("colorscheme everforest")
        vim.o.background = "dark"
    end,
    opts = {
        event = "VimEnter"
    }
}}
-- require("bufferline").setup({
--       options = {  
-- 		  offsets = {
--           {
--             filetype = "NvimTree",
--             text = "Nvim Tree",
--             highlight = "Directory",
-- 			separaror = true,
--             text_align = "left",
--           },
--         },}
-- })

