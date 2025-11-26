return {
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		priority = 100,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			"saadparwaiz1/cmp_luasnip",
			"MattiasMTS/cmp-dbee",
			dependencies = {
				{ "kndndrj/nvim-dbee" }
			},
		},
		config = function()
			require "config.nvim-cmp"
		end,
		opts = {
			sources = {
				{ "cmp-dbee" },
			},
		},
	},
}
