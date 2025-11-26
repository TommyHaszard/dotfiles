return {
	"nvim-java/nvim-java",
	--ft = "java",
	lazy = true,
	dependencies = {
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					-- Your JDTLS configuration goes here
					jdtls = {
						require('jdtls_setup').setup({})
					},
				},
				setup = {
					jdtls = function()
						require("java").setup({
							java_test = {
								enable = true,
								version = "0.43.1",
							},
							java_debug_adapter = {
								enable = true,
							},
							spring_boot_tools = {
								enable = true,
							},
							jdk = {
								auto_install = false,
							},
							notifications = {
								dap = true,
							},
							lombok = {
								enable = true,
							},
						})
						return true
					end,
				},
			},
		},
	},
}
