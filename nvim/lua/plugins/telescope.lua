local builtin = require('telescope.builtin')
return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {'nvim-lua/plenary.nvim'},
    keys = {
        { '<leader><leader>', function() builtin.find_files() end, { desc = 'Telescope find files' } },
        { '<leader>fg', function() builtin.live_grep() end, { desc = 'Telescope live grep' } },
    }
}


