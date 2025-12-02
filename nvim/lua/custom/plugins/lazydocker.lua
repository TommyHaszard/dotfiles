return {
		dir = vim.fn.stdpath("config") .. "/lua/custom/plugins/lazydocker/",
		name = "lazydocker",
		config = function()
			vim.keymap.set('n', '<leader>gd', ':LazyDocker<CR>', { desc = 'LazyDocker' })
		end,
		lazy = false,
		dev = true,
}
