require("telescope").setup({
	defaults = {
		color_devicons = true,
		sorting_strategy = "ascending",
		borderchars = {
			"─", -- top
			"│", -- right
			"─", -- bottom
			"│", -- left
			"┌", -- top-left
			"┐", -- top-right
			"┘", -- bottom-right
			"└", -- bottom-left
		},
		path_displays = { "smart" },
		layout_config = {
			prompt_position = "top",
		}
	},
	pickers = {
		find_files = {
			mappings = {
				i = {
					["<CR>"] = "select_tab",
				},
				n = {
					["<CR>"] = "select_tab",
				},
			},
		},
		buffers = {
			mappings = {
				i = {
					["<CR>"] = "select_tab",
				},
				n = {
					["<CR>"] = "select_tab",
				},
			},
		},
		oldfiles = {
			mappings = {
				i = {
					["<CR>"] = "select_tab",
				},
				n = {
					["<CR>"] = "select_tab",
				},
			},
		},
		man_pages = {
			mappings = {
				i = {
					["<CR>"] = "select_tab",
				},
				n = {
					["<CR>"] = "select_tab",
				},
			},
		},
		help_tags = {
			mappings = {
				i = {
					["<CR>"] = "select_tab",
				},
				n = {
					["<CR>"] = "select_tab",
				},
			},
		}
	}
})

pcall(require("telescope").load_extension, "ui-select")
pcall(require("telescope").load_extension, "file_browser")


local map = vim.keymap.set

local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map({ "n" }, "<leader>sg", builtin.live_grep, { desc = 'Telescope live grep' })
map({ "n" }, "<leader>sb", builtin.buffers, { desc = 'Telescope search buffers' })
map({ "n" }, "<leader>si", builtin.grep_string, { desc = 'Telescope grep strings' })
map({ "n" }, "<leader>so", builtin.oldfiles, { desc = 'Telescope find files' })
map({ "n" }, "<leader>sh", builtin.help_tags, { desc = 'Telescope help tags for plugins' })
map({ "n" }, "<leader>sm", builtin.man_pages, { desc = 'Telescope man pages' })
map({ "n" }, "<leader>sr", builtin.lsp_references, { desc = 'Telescope lsp references' })
map({ "n" }, "<leader>sv", builtin.diagnostics, { desc = 'Telescope diagnostics' })
map({ "n" }, "<leader>si", builtin.lsp_implementations, { desc = 'Telescope lsp implementations' })
map({ "n" }, "<leader>st", builtin.lsp_type_definitions, { desc = 'Telescope type definitions' })
map({ "n" }, "<leader>sf", builtin.current_buffer_fuzzy_find, { desc = 'Telescope curr buffer fuzzy find' })
map({ "n" }, "<leader>sT", builtin.builtin, { desc = 'Telescope builtin search' })
map({ "n" }, "<leader>sc", builtin.git_bcommits, { desc = 'Telescope git bcommits' })
map({ "n" }, "<leader>sk", builtin.keymaps, { desc = 'Telescope search keymaps' })
map("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
