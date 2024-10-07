return {
    {
        "rcarriga/nvim-dap-ui",  -- DAP UI 插件，用于调试
        dependencies = {
            "mfussenegger/nvim-dap",       -- DAP 核心插件
            "nvim-neotest/nvim-nio",       -- Neotest 的依赖
            "mfussenegger/nvim-dap-python" -- Python 支持
        },
        config = function()
            require("dapui").setup()  -- 初始化 DAP UI
            local conda_path = os.getenv("CONDA_PREFIX")  -- 获取 Conda 环境路径
            if not conda_path then
                conda_path = vim.fn.expand("$HOME/miniconda3")  -- 默认路径
            end
            require("dap-python").setup(conda_path .. "/bin/python")  -- 配置 Python DAP
        end,
        keys = {
            { "<leader>du", "<cmd>lua require('dapui').toggle()<CR>", desc = "Toggle DAP UI" },  -- 切换 DAP UI
            { "<leader>b",  "<cmd>DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },        -- 切换断点
            { "<F5>",       "<cmd>DapContinue<CR>", desc = "Continue Debugging" },              -- 继续调试
            { "<F6>",       "<cmd>DapStepOver<CR>", desc = "Step Over" },                       -- 单步跳过
            { "<F7>",       "<cmd>DapStepInto<CR>", desc = "Step Into" },                       -- 单步进入
        }
    },
}

