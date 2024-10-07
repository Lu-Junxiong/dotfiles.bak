return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
        { '<leader><leader>',
            function()
                require('telescope.builtin').find_files({})
            end, { desc = 'Telescope find files' } },
        { '<leader>fg', function() require('telescope.builtin').live_grep() end, { desc = 'Telescope live grep' } },
    },
    config = function()
        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = require("telescope.actions").close,
                    },
                },
            },
            pickers = {
                find_files = {
                    find_command = {
                        'rg',
                        '--files',
                        '--glob',
                        '*.py',
                        '--glob',
                        '*.lua',
                        '--glob',
                        '*.ini',
                        '--glob',
                        '*.json',
                        '--glob',
                        '*.ipynb',
                        '--glob',
                        '*.cpp',
                        '--glob',
                        '*.yml',
                        '--glob',
                        '*.yaml',
                        '--glob',
                        '*.toml',
                        '--glob',
                        '*.md',
                    }
                }
            }
        }
    end,
}
