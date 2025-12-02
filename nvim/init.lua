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

vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
	{ src = "https://github.com/nvim-java/lua-async-await" },
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/nvim-java/nvim-java-dap" },
	{ src = "https://github.com/OXY2DEV/markview.nvim" },
})

--local pm = require("nvim.lua.plugins.plugin_manager")
--pm.add({ src = "https://github.com/Saghen/blink.cmp", tag = "v1.7.0" })
require("config.lazy")

--require("nvim-autopairs").setup()
--require('oil').setup({
--	keymaps = {
--		["<CR>"] = {
--			callback = function()
--				local oil = require('oil')
--				local entry = oil.get_cursor_entry()
--
--				if entry and entry.type == "file" then
--					oil.select({ tab = true })
--				else
--					oil.select()
--				end
--			end,
--		},
--	},
--})
--require("gitsigns").setup()
--require("tiny-inline-diagnostic").setup()
--require("markview").setup()

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
--require("nvim.lua.custom.plugins.ssh-telescope").setup()

vim.keymap.set("n", "<leader>sd", ":Oil --float<CR>", { noremap = true, silent = true })

vim.keymap.set('n', '<leader>hn', ':Gitsigns next_hunk<CR>', { desc = 'Gitsigns jump to next hunk' })
vim.keymap.set('n', '<leader>hp', ':Gitsigns next_hunk<CR>', { desc = 'Gitsigns jump to next hunk' })
