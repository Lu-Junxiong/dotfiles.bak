vim.cmd.colorscheme "everforest"
vim.o.background = "dark"
require("bufferline").setup({
      options = {  
		  offsets = {
          {
            filetype = "NvimTree",
            text = "Nvim Tree",
            highlight = "Directory",
			separaror = true,
            text_align = "left",
          },
        },}
})
