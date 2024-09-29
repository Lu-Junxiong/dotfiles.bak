return { {
    'akinsho/bufferline.nvim',
    event = "VimEnter",
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    keys = {
        { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
        { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    },
    config = function()
        require('bufferline').setup {
        }
    end,
} }
