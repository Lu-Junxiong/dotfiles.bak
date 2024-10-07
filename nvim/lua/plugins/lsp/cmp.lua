local cmp_config = function()
    local luasnip = require("luasnip")
    local cmp = require("cmp")
    local kind_icons = {
        Class = '🅒',
        Color = "🖌",
        Constant = "𝜋",
        Constructor = "⬡",
        Enum = "",
        EnumMember = "",
        Event = "",
        Field = "",
        File = "",
        Folder = "",
        Function = "ƒ",
        Interface = "",
        Keyword = "",
        Method = "𝘮",
        Module = "",
        Operator = "≠",
        Property = "∷",
        Reference = "⊷",
        Snippet = "{}",
        Struct = "",
        Text = "𝓣",
        TypeParameter = "×",
        Unit = "()",
        Variable = "𝓧"
    }

    cmp.setup({
        sources = {{
            name = "nvim_lsp"
        }, {
            name = "path"
        }, {
            name = "buffer"
        }, {
            name = "luasnip"
        }},
        mapping = {
            ["<Tab>"] = cmp.mapping.confirm({
                select = true
            }),
            ["<C-Space>"] = cmp.mapping.complete(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<C-k>'] = cmp.mapping.select_prev_item(),},
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end
        },
        formatting = {
            fields = {"kind", "abbr", "menu"},
            format = function(entry, vim_item)
                vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                vim_item.menu = ({
                    omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
                    nvim_lsp = "[LSP]",
                    luasnip = "[Snippet]",
                    buffer = "[Buffer]",
                    spell = "[Spell]",
                    latex_symbols = "[Symbols]",
                    cmdline = "[CMD]",
                    path = "[Path]"
                })[entry.source.name]
                return vim_item
            end
        },
        window = {
            completion = {
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                col_offset = -3,
                side_padding = 0
            }
        },
        -- completion = {
        --     completeopt = "menu,menuone,noinsert"
        -- }
    })
    -- Customization for Pmenu
    -- vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#FFFFFF", fg = "NONE" })
    -- vim.api.nvim_set_hl(0, "Pmenu", { fg = "NONE", bg = "#ecf1de" })

    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline({
            ['<C-j>'] = {
                c = cmp.mapping.select_next_item({
                    behavior = cmp.SelectBehavior.Insert
                })
            },
            ['<C-k>'] = {
                c = cmp.mapping.select_prev_item({
                    behavior = cmp.SelectBehavior.Insert
                })
            }
        }),
        sources = cmp.config.sources({{
            name = 'cmdline'
        }}, {{
            name = 'path'
        }}),
    })

    cmp.setup.cmdline({'/', '?'}, {
        mapping = cmp.mapping.preset.cmdline({
            ['<C-j>'] = {
                c = cmp.mapping.select_next_item({
                    behavior = cmp.SelectBehavior.Insert
                })
            },
            ['<C-k>'] = {
                c = cmp.mapping.select_prev_item({
                    behavior = cmp.SelectBehavior.Insert
                })
            }
        }),
        sources = cmp.config.sources({{
            name = 'buffer'
        }})
    })
end
return {{
    "hrsh7th/nvim-cmp",
    dependencies = {"L3MON4D3/LuaSnip", "hrsh7th/cmp-path", 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-cmdline',
                    "hrsh7th/cmp-nvim-lsp"},
    config = cmp_config
}}
