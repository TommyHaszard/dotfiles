return {
		dir = vim.fn.stdpath("config") .. "/lua/custom/plugins/sshpicker/",
		name = "sshpicker",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
		config = function ()
			vim.keymap.set('n', '<leader>ss', ':SSHPicker<CR>', { desc = 'SSH Picker' })
		end,
		lazy = false,
		dev = true,
}
