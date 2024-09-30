local mason_opts = {
    ui = {
        icons = {
            package_installed = "✓", -- 安装成功的图标
            package_pending = "➜", -- 安装中状态图标
            package_uninstalled = "✗", -- 未安装状态图标
        },
        border = "rounded", -- 窗口边框样式
    },
}

local config = function()
    -- 获取补全能力
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- 设置 LSP 窗口的默认边框样式
    require("lspconfig.ui.windows").default_options.border = "rounded"

    -- 自动命令: 当 LSP 附加到缓冲区时
    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Lsp Actions",
        callback = function(event)
            local opts = { buffer = event.buf }
            local keymap = vim.keymap.set
            -- 显示悬浮信息
            keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
            -- 跳转到定义
            keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        end,
    })

    -- 初始化 Mason
    require("mason").setup(mason_opts)
    require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ruff_lsp" }, -- 确保安装的 LSP
    })

    -- Lua 语言服务器设置
    require('lspconfig').lua_ls.setup({
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = { globals = { "vim" } }, -- 允许全局变量 "vim"
            },
        },
    })

    -- Ruff LSP 设置
    require('lspconfig').ruff_lsp.setup {
        capabilities = capabilities,
        init_options = {
            settings = {
                args = {}, -- 可选: 额外的 Ruff CLI 参数
            }
        }
    }

    -- Pyright 设置
    require('lspconfig').pyright.setup {
        capabilities = capabilities,
        settings = {
            pyright = {
                disableOrganizeImports = true, -- 禁用导入组织
            },
            python = {
                analysis = {
                    ignore = { '*' }, -- 忽略所有文件，使用 Ruff 进行 linting
                },
            },
        },
    }

    -- 设置补全
    local cmp = require("cmp")
    cmp.setup({
        sources = { { name = "nvim_lsp" }, { name = "path" }, { name = "buffer" } },
        mapping = {
            ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 确认选择
            ["<C-Space>"] = cmp.mapping.complete(),            -- 补全建议
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),           -- 向上滚动文档
            ['<C-f>'] = cmp.mapping.scroll_docs(4),            -- 向下滚动文档
            ['<Down>'] = cmp.mapping.select_next_item(),       -- 选择下一个项
            ['<Up>'] = cmp.mapping.select_prev_item(),         -- 选择上一个项
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body) -- 使用 LuaSnip 扩展
            end,
        },
    })

    -- 设置命令行补全
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline({
            ['<Down>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
            ['<Up>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
        }),
        sources = cmp.config.sources({
            { name = 'cmdline' },
        }, {
            { name = 'path' },
        })
    })

    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline({
            ['<Down>'] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
            ['<Up>'] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
        }),
        sources = cmp.config.sources({
            { name = 'buffer' },
        })
    })
end

-- 重写 vim.schedule 以捕获错误
local original_schedule = vim.schedule
vim.schedule = function(callback)
    original_schedule(function()
        local status, err = pcall(callback)
        if not status then
            if string.match(err, "semantic_tokens") then
                return                                                         -- 忽略特定错误
            else
                vim.notify("Error in schedule: " .. err, vim.log.levels.DEBUG) -- 记录其他错误
            end
        end
    end)
end

return {
    {
        "williamboman/mason.nvim",               -- Mason 插件
        dependencies = {
            "williamboman/mason-lspconfig.nvim", -- Mason LSP 配置插件
            "neovim/nvim-lspconfig",             -- Neovim LSP 配置
            "hrsh7th/nvim-cmp",                  -- nvim-cmp 插件
            "hrsh7th/cmp-path",                  -- 路径补全
            'hrsh7th/cmp-buffer',                -- 缓冲区补全
            'hrsh7th/cmp-cmdline',               -- 命令行补全
            "hrsh7th/cmp-nvim-lsp",              -- LSP 补全
            "L3MON4D3/LuaSnip",                  -- LuaSnip 插件
        },
        lazy = false,                            -- 不延迟加载
        config = config,                         -- 配置函数
    },
    {
        "kmontocam/nvim-conda",                     -- Conda 插件
        lazy = false,                               -- 不延迟加载
        dependencies = { "nvim-lua/plenary.nvim" }, -- 依赖插件
        event = "VimEnter",                         -- 在 Vim 进入时加载
    },
}
