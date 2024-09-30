return {
    {
        -- 插件名称
        'akinsho/toggleterm.nvim',
        version = "*", -- 使用任意版本

        -- 配置函数
        config = function()
            require("toggleterm").setup {
                open_mapping = [[<c-\>]], -- 设置打开终端的快捷键
                hide_numbers = true,      -- 不显示行号

                -- 当 Neovim 更改当前目录时，终端将在下次打开时自动更改目录
                autochdir = false,

                float_opts = {
                    border = 'double',  -- 浮动窗口的边框样式
                    winblend = 36,      -- 浮动窗口的透明度
                    title_pos = 'left', -- 标题位置
                    width = 180,        -- 浮动窗口宽度
                    height = 30,        -- 浮动窗口高度
                },
            }
        end,

        -- 按键绑定
        keys = {
            { "<leader>t",  "<cmd>ToggleTerm direction=float<cr>",              desc = "ToggleTerm float" },   -- 切换浮动终端
            { "<leader>bt", "<cmd>ToggleTerm direction=horizontal size=19<cr>", desc = "ToggleTerm bottom" },  -- 切换底部终端
            { "<leader>T",  "<cmd>ToggleTerm direction=tab<cr>",                desc = "ToggleTerm tab" },     -- 切换标签页终端
            { "<leader>lt", "<cmd>ToggleTerm direction=vertical size=89<cr>",   desc = "ToggleTerm right" },   -- 切换右侧终端
        },
    }
}
