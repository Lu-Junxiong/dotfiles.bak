local mason_opts = {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        },
        border = "rounded"
    }
}

return {{
    "williamboman/mason.nvim",
    dependencies = {"williamboman/mason-lspconfig.nvim"},
    lazy = false,
    config = function()
        require("mason").setup(mason_opts)
        require("mason-lspconfig").setup({
            ensure_installed = {"lua_ls", "pyright", "ruff_lsp"}
        })
    end
}}
