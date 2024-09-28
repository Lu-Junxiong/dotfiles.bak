function _G.get_oil_winbar()
    local dir = require("oil").get_current_dir()
    if dir then
        return vim.fn.fnamemodify(dir, ":~")
    else
        -- If there is no current directory (e.g. over ssh), just show the buffer name
        return vim.api.nvim_buf_get_name(0)
    end
end
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
return {{
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {{
        "echasnovski/mini.icons",
        opts = {}
    }},
    keys = {{'<leader>e', function()
        vim.cmd(":Oil")
    end, {
        desc = 'Oil edit'
    }}},
    config = function()
        require("oil").setup({
            win_options = {
                winbar = "%!v:lua.get_oil_winbar()"
            },
            keymaps = {
                ['<C-p>'] = {
                    callback = function()
                        M.preview.callback() 
                    end,
                    desc = M.preview.desc,
                }

            }
        })
    end
}}
