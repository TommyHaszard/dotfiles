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

vim.g.mapleader = " "

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/mfussenegger/nvim-jdtls" },
})

require "mason".setup()
require "mason-lspconfig".setup {
	automatic_enable = {
		exclude = {
			"jdtls"
		}
	}
}
vim.lsp.enable({ "lua_ls" })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        require('jdtls_setup').setup()
    end
})

vim.cmd("colorscheme vague")
