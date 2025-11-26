return {
	'kndndrj/cmp-dbee',
	dependencies = {
		{ 'kndndrj/nvim-dbee' },
		{ 'hrsh7th/nvim-cmp' },
	},
	ft = { 'sql', 'mysql', 'plsql' },
	config = function()
		require('cmp-dbee').setup({})
	end,
}
