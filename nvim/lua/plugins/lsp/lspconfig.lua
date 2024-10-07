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
return {{
    "neovim/nvim-lspconfig",
    config = function()
        require("lspconfig.ui.windows").default_options.border = "rounded"
        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "Lsp Actions",
            callback = function(event)
                local opts = {
                    buffer = event.buf
                }
                local keymap = vim.keymap.set
                keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
            end
        })
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require('lspconfig').lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {"vim"}
                    }
                }
            }
        })
        require('lspconfig').ruff_lsp.setup {
            capabilities = capabilities,
            init_options = {
                settings = {
                    args = {}
                }
            }
        }
        require('lspconfig').pyright.setup {
            capabilities = capabilities,
            settings = {
                pyright = {
                    disableOrganizeImports = true
                },
                python = {
                    analysis = {
                        ignore = {'*'}
                    }
                }
            }
        }
    end
}}
