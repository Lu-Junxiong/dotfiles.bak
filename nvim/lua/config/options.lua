local opt = vim.opt  -- 简化选项设置

-- 基本选项
opt.tabstop = 4               -- 一个制表符的空格数
opt.shiftwidth = 4            -- 使用 '>>' 和 '<<' 时的空格数
opt.softtabstop = 4           -- 编辑时制表符的行为
opt.expandtab = true          -- 将制表符转换为空格
opt.smartindent = true        -- 智能缩进
opt.wrap = true               -- 自动换行
opt.autoindent = true         -- 自动缩进新行
opt.smartindent = true
opt.cursorline = true         -- 高亮当前行
opt.scrolloff = 4             -- 滚动时保持行数

-- 行号和界面
opt.number = true             -- 显示行号
opt.relativenumber = true     -- 显示相对行号
opt.numberwidth = 2           -- 行号列宽

-- 搜索相关
opt.incsearch = true          -- 增量搜索
opt.ignorecase = true         -- 忽略大小写
opt.smartcase = true          -- 智能大小写匹配
opt.hlsearch = true           -- 高亮搜索结果

-- 颜色和字符设置
opt.termguicolors = true      -- 支持真彩色
--opt.colorcolumn = "100"       -- 第100列高亮
opt.encoding = "UTF-8"        -- 编码设置
opt.clipboard:append("unnamedplus") -- 使用系统剪贴板

-- 文件和鼠标设置
opt.swapfile = false          -- 禁用交换文件
opt.backup = false            -- 禁用备份
opt.mouse:append("a")        -- 启用鼠标支持

-- 折叠设置
opt.foldlevel = 99            -- 初始折叠级别
opt.foldcolumn = '1'          -- 折叠列宽
opt.foldnestmax = 3            -- 最大嵌套折叠层级
opt.foldminlines = 1          -- 折叠的最小行数
opt.foldenable = true         -- 启用折叠
opt.foldlevelstart = 99       -- 启动时的折叠级别
opt.foldmethod = "expr"       -- 使用表达式折叠
opt.foldexpr = "nvim_treesitter#foldexpr()" -- Treesitter 折叠
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]] -- 填充字符设置

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
