return {{
    'akinsho/bufferline.nvim',
    event = "VimEnter",
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require('bufferline').setup{
    --         options = {
    --             offsets = {
    --                 {
    --                     filetype = "NvimTree",
    --                     text = "Nvim Tree",
    --                     highlight = "Directory",
    --                     separator = true,
    --                     text_align = "left",
    --                 },
    --             },
    --         },
        }
    end,
}}
