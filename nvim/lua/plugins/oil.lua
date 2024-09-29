-- function _G.get_oil_winbar()
--     local dir = require("oil").get_current_dir()
--     if dir then
--         return vim.fn.fnamemodify(dir, ":~")
--     else
--         -- If there is no current directory (e.g. over ssh), just show the buffer name
--         return vim.api.nvim_buf_get_name(0)
--     end
-- end

local M = {}
M.preview = {
    desc = "Open the entry under the cursor in a preview window, or close the preview window if already open",
    callback = function()
        local oil = require("oil")
        local util = require("oil.util")
        local entry = oil.get_cursor_entry()
        if not entry then
            vim.notify("Could not find entry under cursor", vim.log.levels.ERROR)
            return
        end
        local winid = util.get_preview_win()
        if winid then
            local cur_id = vim.w[winid].oil_entry_id
            if entry.id == cur_id then
                vim.api.nvim_win_close(winid, true)
                if util.is_floating_win() then
                    local layout = require("oil.layout")
                    local win_opts = layout.get_fullscreen_win_opts()
                    vim.api.nvim_win_set_config(0, win_opts)
                end
                return
            end
        end
        oil.open_preview({
            vertical = true,
            split = 'botright'
        })
    end
}

return { {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { {
        "echasnovski/mini.icons",
        opts = {}
    } },
    keys = {
        { '<leader>e', function()
            vim.cmd(":Oil")
        end, {
            desc = 'Oil edit'
        } },
        {
            '<leader>o', function()
            vim.cmd(":Oil --float")
        end, { desc = 'Oil float' }
        }
    },
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            win_options = {
                -- winbar = "%!v:lua.get_oil_winbar()"
            },
            columns = {
                "size",
                "icon",
                -- "permissions",
                -- "mtime",
            },
            reverse_columns = true,
            float = {
                -- Padding around the floating window
                padding = 1,
                max_width = 200,
                max_height = 40,
                border = "rounded",
                win_options = {
                    winblend = 10,
                },
                preview_split = "right",
            },
            keymaps = {
                ['<C-p>'] = {
                    callback = function()
                        M.preview.callback()
                    end,
                    desc = M.preview.desc,
                },
                ["<leader>o"] = "actions.close",
                ["<leader>e"] = "actions.close",
                -- ['<C-p>'] = function ()
                --     require("oil").open_float("~/dotfiles")
                -- end
            },
            cleanup_delay_ms = 1000,
            view_options = {
                -- Show files and directories that start with "."
                show_hidden = false,
                -- This function defines what is considered a "hidden" file
                is_hidden_file = function(name, bufnr)
                    return vim.startswith(name, ".")
                end,
                -- This function defines what will never be shown, even when `show_hidden` is set
                is_always_hidden = function(name, bufnr)
                    return false
                end,
                -- Sort file names in a more intuitive order for humans. Is less performant,
                -- so you may want to set to false if you work with large directories.
                natural_order = false,
                -- Sort file and directory names case insensitive
                case_insensitive = true,
                sort = {
                    -- sort order can be "asc" or "desc"
                    -- see :help oil-columns to see which columns are sortable
                    { "type", "asc" },
                    { "name", "asc" },
                },
                lsp_file_methods = {
                    -- Enable or disable LSP file operations
                    enabled = false,
                    -- Time to wait for LSP file operations to complete before skipping
                    timeout_ms = 9999,
                    -- Set to true to autosave buffers that are updated with LSP willRenameFiles
                    -- Set to "unmodified" to only save unmodified buffers
                    autosave_changes = false,
                },
            },
        })
    end
} }
