return {
    {
        'akinsho/bufferline.nvim',                    -- 插件名称
        event = "VimEnter",                           -- 在 Vim 启动时加载插件
        version = "*",                                -- 使用任意版本
        dependencies = 'nvim-tree/nvim-web-devicons', -- 依赖的图标插件

        -- 按键绑定
        keys = {
            { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" }, -- 切换到上一个缓冲区
            { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" }, -- 切换到下一个缓冲区
        },

        -- 配置函数
        config = function()
            require('bufferline').setup {
                options = {
                    numbers = "both", -- 显示缓冲区的编号（可以是 "none", "ordinal", "both"）
                    close_icon = "", -- 自定义关闭图标
                    right_mouse_command = "bdelete! %d", -- 右键菜单的关闭命令
                    separator_style = "double", -- 分隔符样式（"slant", "thick", "thin", "double", "none"）
                    show_buffer_close_icons = true, -- 是否显示关闭图标
                }
            }
        end,
    }
}
