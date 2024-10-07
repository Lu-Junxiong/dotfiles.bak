return {
    -- 插件名称
    "folke/noice.nvim",

    -- 依赖的其他插件
    dependencies = {
        'rcarriga/nvim-notify', -- 通知插件
        'MunifTanjim/nui.nvim', -- 界面组件库
    },

    -- 在 "VeryLazy" 事件时加载插件
    event = "VeryLazy",

    opts = {
        lsp = {
            override = {
                -- 启用 Noice 针对特定 LSP 工具函数
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },

        routes = {
            {
                -- 过滤以显示特定消息事件
                filter = {
                    event = "msg_show",             -- 监听消息显示事件
                    any = {
                        { find = "%d+L, %d+B" },    -- 行和字节计数消息
                        { find = "; after #%d+" },  -- 包含 "after #" 的消息
                        { find = "; before #%d+" }, -- 包含 "before #" 的消息
                    },
                },
                view = "mini", -- 对于过滤的消息使用 mini 视图
            },
            {

                filter = { event = "notify",  find = "^.*WARNING.*vim.treesitter.get_parser.*$"},
                opts = { skip = true },
            }
        },

        presets = {
            bottom_search = true,         -- 搜索结果显示在底部
            command_palette = true,       -- 启用命令面板显示
            long_message_to_split = true, -- 将长消息拆分以提高可读性
        },
    },

    keys = {
        {
            "<leader>snl",
            function()
                require("noice").cmd("last") -- 显示最后一条消息
            end,
            desc = "显示最后一条消息"
        },
        {
            "<leader>snh",
            function()
                require("noice").cmd("history") -- 显示消息历史
            end,
            desc = "显示消息历史"
        },
        {
            "<leader>sna",
            function()
                require("noice").cmd("all") -- 显示所有消息
            end,
            desc = "显示所有消息"
        },
        {
            "<leader>snd",
            function()
                require("noice").cmd("dismiss") -- 关闭所有消息
            end,
            desc = "关闭所有消息"
        },
    },

    config = function(_, opts)
        -- HACK: 在 Lazy 加载插件时清除旧消息
        if vim.o.filetype == "lazy" then
            vim.cmd([[messages clear]]) -- 清除消息
        end
        require("noice").setup(opts)    -- 初始化 Noice
    end
}
