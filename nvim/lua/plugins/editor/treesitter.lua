return {{
    -- 插件名称
    "nvim-treesitter/nvim-treesitter",

    run = ":TSUpdate",

    -- 配置插件
    config = function()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = {"python", -- Python 语言
            "lua", 
            "ini", 
            "json",
            "yaml", 
            "toml", 
            "markdown", 
            "markdown_inline",
            "bash", 
            "vim" 
            },
            highlight = {
                enable = true, 
                additional_vim_regex_highlighting = false
            },

            indent = {
                enable = true 
            }
        }
    end
}, 
{
    "romgrk/nvim-treesitter-context",
    config = function()
        require("treesitter-context").setup({
            enable = true,
            throttle = true,
            max_lines = 1,
            patterns = {
                default = {"class", "function", "method"}
            }
        })
    end
}
}
