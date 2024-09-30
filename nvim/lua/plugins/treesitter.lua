return {
    {
        -- 插件名称
        "nvim-treesitter/nvim-treesitter",

        -- 安装后运行 :TSUpdate 以确保树状解析器是最新的
        run = ":TSUpdate",

        -- 配置插件
        config = function()
            -- 引入 nvim-treesitter 的配置模块
            require 'nvim-treesitter.configs'.setup {
                -- 确保安装以下语言的树状解析器
                ensure_installed = {
                    "python",          -- Python 语言
                    "lua",             -- Lua 语言
                    "ini",             -- INI 文件格式
                    "json",            -- JSON 文件格式
                    "yaml",            -- YAML 文件格式
                    "toml",            -- TOML 文件格式
                    "markdown",        -- Markdown 文件格式
                    "markdown_inline", -- Markdown 行内语法
                    "bash",            -- Bash 脚本
                    "vim"              -- Vim 脚本
                },

                -- 高亮配置
                highlight = {
                    enable = true,                             -- 启用语法高亮
                    additional_vim_regex_highlighting = false, -- 禁用额外的 Vim 正则表达式高亮
                },

                -- 缩进配置
                indent = {
                    enable = true, -- 启用智能缩进
                },
            }
        end,
    },
}
