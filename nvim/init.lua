vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.showtabline = 2
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.cursorcolumn = false
vim.o.ignorecase = true
vim.o.smartindent = true
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.number = true
vim.o.winborder = "rounded"

vim.g.mapleader = " "

--local pm = require("nvim.lua.plugins.plugin_manager")
--pm.add({ src = "https://github.com/Saghen/blink.cmp", tag = "v1.7.0" })
require("config.lazy")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		vim.bo.autoindent = false
		vim.bo.smartindent = false
		vim.bo.cindent = false

		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.expandtab = true
	end,
})

require('keymaps')

vim.keymap.set('n', '<leader>hn', ':Gitsigns next_hunk<CR>', { desc = 'Gitsigns jump to next hunk' })
vim.keymap.set('n', '<leader>hp', ':Gitsigns next_hunk<CR>', { desc = 'Gitsigns jump to next hunk' })
