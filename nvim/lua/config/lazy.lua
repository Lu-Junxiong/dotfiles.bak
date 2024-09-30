-- 定义 lazy.nvim 的路径
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- 检查 lazy.nvim 是否已经存在
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git" -- lazy.nvim 的 Git 仓库地址

    -- 使用 git 克隆 lazy.nvim 仓库
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath
    })

    -- 检查 git 命令的执行结果
    if vim.v.shell_error ~= 0 then
        -- 如果克隆失败，显示错误信息并退出
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." }
        }, true, {})
        vim.fn.getchar() -- 等待用户输入
        os.exit(1)       -- 退出程序
    end
end

-- 将 lazy.nvim 添加到 runtime path
vim.opt.rtp:prepend(lazypath)

-- 设置 lazy.nvim 的配置
require("lazy").setup({
    spec = {
        { import = "plugins" } -- 导入插件配置
    },
    defaults = {
        lazy = false,   -- 默认不延迟加载插件
        version = false -- 不自动检查插件版本
    },
    install = {
        colorscheme = { "everforest" } -- 默认安装的配色方案
    },
    checker = {
        enabled = false, -- 禁用插件更新检查
        notify = false   -- 禁用更新通知
    },
    performance = {
        rtp = {
            disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } -- 禁用不必要的插件
        }
    }
})
