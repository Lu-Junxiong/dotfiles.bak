return {
    {
        "jiaoshijie/undotree",
        dependencies = "nvim-lua/plenary.nvim",
        lazy = false,
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<CR> <cmd>UndotreeFocus<CR>" },
        },
    }
}
