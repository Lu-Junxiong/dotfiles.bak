  return {
  { "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {{'filename', path = 3, newfile_status=true, file_status=true}},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
      }
    end,
  },
  { "neanias/everforest-nvim" },
  {
  'nvimdev/dashboard-nvim',
   event = 'VimEnter',
   config = function()
      local logo = [[
██╗  ██╗███████╗██╗     ██╗      ██████╗ 
██║  ██║██╔════╝██║     ██║     ██╔═══██╗
███████║█████╗  ██║     ██║     ██║   ██║
██╔══██║██╔══╝  ██║     ██║     ██║   ██║
██║  ██║███████╗███████╗███████╗╚██████╔╝
╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ ╚═════╝ 
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
     require('dashboard').setup {
	  theme = 'doom',
      hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
	config = {
		header = vim.split(logo, "\n"),
		center = {
			{ action = 'lua require("telescope.builtin").find_files()', desc = " Find Files ", icon = "🔍", key = "f" },
			{ action = 'lua vim.cmd("enew")', desc = " New File", icon = " ", key = "n" },
   	        { action = 'lua require("telescope.builtin").live_grep()',      desc = " Find Text",       icon = " ", key = "g" },
            { action = 'lua require("telescope.builtin").find_files({ cwd = vim.fn.expand("~/.config/nvim") })', desc = " Config", icon = " ", key = "c" },
			{ action = 'lua vim.cmd("qa!")', desc = " Quit", icon = "🚪", key = "q" },
		},
		footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
		end,
	  },
     } 
   end,
   dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },
}
