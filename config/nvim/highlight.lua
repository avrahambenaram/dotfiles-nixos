vim.o.termguicolors = true
vim.o.t_Co = '256'

require("nvim-highlight-colors").setup {
	render = 'background',
	enable_named_colors = true,
	enable_tailwind = true,
}
