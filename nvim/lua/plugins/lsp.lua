local mason_opts = {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
        border = "rounded",
    },
}

local config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("lspconfig.ui.windows").default_options.border = "rounded"

    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Lsp Actions",
        callback = function(event)
            local opts = { buffer = event.buf }
            local keymap = vim.keymap.set
            keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
            keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
        end,
    })

    -- Setup Mason
    require("mason").setup(mason_opts)
    require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ruff_lsp" },
    })
    -- Lua setup
    lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = { globals = { "vim" } },
            },
        },
    })
    lspconfig.ruff_lsp.setup {
        capabilities = capabilities,
        init_options = {
            settings = {
                -- Any extra CLI arguments for `ruff` go here.
                args = {},
            }
        }
    }
    -- Setup completion
    require("cmp").setup({
        sources = { { name = "nvim_lsp" }, { name = "path" } },
        mapping = {
            ["<CR>"] = require("cmp").mapping.confirm({ select = true }),
            ["<C-Space>"] = require("cmp").mapping.complete(),
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
    })
end
local original_schedule = vim.schedule
vim.schedule = function(callback)
    original_schedule(function()
        local status, err = pcall(callback)
        if not status then
            if string.match(err, "semantic_tokens") then
                return
            else
                vim.notify("Error in schedule: " .. err, vim.log.levels.DEBUG)
            end
        end
    end)
end
return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
        },
        lazy = false,
        config = config,
    },
    {
        "kmontocam/nvim-conda",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VimEnter",
    },
}
