local M = {}

-- 预览功能的配置
M.preview = {
    -- 描述预览功能的作用
    desc = "Open the entry under the cursor in a preview window, or close the preview window if already open",

    -- 回调函数，执行预览操作
    callback = function()
        local oil = require("oil")
        local util = require("oil.util")
        local entry = oil.get_cursor_entry() -- 获取光标下的条目
        if not entry then
            vim.notify("Could not find entry under cursor", vim.log.levels.ERROR) -- 找不到条目时通知用户
            return
        end

        local winid = util.get_preview_win() -- 获取当前预览窗口的 ID

        if winid then
            local cur_id = vim.w[winid].oil_entry_id -- 当前预览窗口的条目 ID

            -- 如果当前预览的条目与光标下的条目相同，则关闭预览窗口
            if entry.id == cur_id then
                vim.api.nvim_win_close(winid, true)
                if util.is_floating_win() then -- 检查是否是浮动窗口
                    local layout = require("oil.layout")
                    local win_opts = layout.get_fullscreen_win_opts() -- 获取全屏窗口选项
                    vim.api.nvim_win_set_config(0, win_opts) -- 设置窗口配置
                end
                return
            end
        end

        -- 打开新的预览窗口
        oil.open_preview({
            vertical = true,
            split = 'botright'
        })
    end
}

local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"
  
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
  
    -- default mappings
    api.config.mappings.default_on_attach(bufnr)
  
    -- custom mappings
    vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
    vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
  end

return {{
    -- 插件名称
    'stevearc/oil.nvim',
    opts = {}, -- 插件选项，当前为空

    -- 可选依赖
    dependencies = {{
        "echasnovski/mini.icons",
        opts = {} -- 依赖的插件选项
    }},

    -- 按键绑定
    keys = { 
    -- {
    --     '<leader>e',
    --     function()
    --         vim.cmd(":Oil")
    --     end,
    --     { desc = 'Oil edit' }
    -- },
    {'<leader>e', function()
        vim.cmd(":Oil --float") -- 以浮动窗口打开 Oil 文件浏览器
    end, {
        desc = 'Oil float'
    }}
},

    -- 配置函数
    config = function()
        require("oil").setup({
            default_file_explorer = true, -- 设置为默认文件浏览器
            win_options = {
                -- 可选：winbar = "%!v:lua.get_oil_winbar()"
            },
            columns = {"size", -- 显示文件大小
            "icon" -- 显示文件图标
            -- "permissions",  -- 可选：显示文件权限
            -- "mtime",  -- 可选：显示文件修改时间
            },
            float = {
                -- 浮动窗口的配置
                padding = 1, -- 浮动窗口周围的填充
                max_width = 200, -- 最大宽度
                max_height = 40, -- 最大高度
                border = "rounded", -- 边框样式
                win_options = {
                    winblend = 10 -- 浮动窗口的透明度
                },
                preview_split = "right" -- 预览分割位置
            },
            keymaps = {
                ['<C-p>'] = {
                    callback = function()
                        M.preview.callback() -- 绑定 Ctrl+p 键进行预览
                    end,
                    desc = M.preview.desc -- 绑定描述
                },
                -- ["<leader>o"] = "actions.close",     -- 绑定关闭操作
                ["<leader>e"] = "actions.close", -- 绑定关闭操作
                ['gy'] = {
                    desc = 'Copy filepath to system clipboard',
                    callback = function()
                        require('oil.actions').copy_entry_path.callback()
                        vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
                    end
                }
            },
            cleanup_delay_ms = 1000, -- 清理延迟时间
            view_options = {
                show_hidden = false, -- 不显示隐藏文件
                is_hidden_file = function(name, bufnr)
                    return vim.startswith(name, ".") -- 判断以 "." 开头的文件为隐藏文件
                end,
                is_always_hidden = function(name, bufnr)
                    return false -- 永远不隐藏的文件
                end,
                natural_order = false, -- 不使用自然排序
                case_insensitive = true, -- 排序时不区分大小写
                sort = {{"type", "asc"}, -- 按类型升序排序
                {"name", "asc"} -- 按名称升序排序
                },
                lsp_file_methods = {
                    enabled = false, -- 禁用 LSP 文件操作
                    timeout_ms = 9999, -- LSP 文件操作超时时间
                    autosave_changes = false -- 禁用自动保存
                }
            }
        })
    end
}, {
    "nvim-tree/nvim-tree.lua",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    opt = {
        event = "VimEnter"
    },
    config = function()
        require("nvim-tree").setup({
            sort = {
                sorter = "case_sensitive"
            },
            view = {
                width = 30
            },
            renderer = {
                group_empty = true
            },
            filters = {
                dotfiles = true
            },
            on_attach = my_on_attach,
        })

    end,
    keys = {
        { "<leader>j", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" }
    }
}}
