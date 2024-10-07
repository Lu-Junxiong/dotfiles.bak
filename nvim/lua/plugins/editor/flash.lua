return {
    "folke/flash.nvim", -- 插件名称
    event = "VeryLazy", -- 在非常懒惰的情况下加载插件

    keys = {
        {
            "s",                        -- 快捷键 's'
            mode = { "n", "x", "o" },   -- 适用模式：普通、可视、操作
            function()
                require("flash").jump() -- 跳转到匹配的位置
            end,
            desc = "Flash"              -- 描述
        },
    }
}
