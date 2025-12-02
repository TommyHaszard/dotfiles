return {
		dir = vim.fn.stdpath("config") .. "/lua/custom/plugins/lazygit/",
		name = "lazygit",
		config = function ()
			vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { desc = 'LazyGit' })
		end,
		lazy = false,
		dev = true,
}
