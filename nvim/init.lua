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
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/ribru17/bamboo.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/mfussenegger/nvim-jdtls" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/jsongerber/telescope-ssh-config" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
})

local pm = require("plugin_manager")
pm.add({ src = "https://github.com/Saghen/blink.cmp", tag = "v1.7.0" })

require "mason".setup()
require "mason-lspconfig".setup {
	automatic_enable = {
		exclude = {
			"jdtls"
		}
	}
}
require("nvim-autopairs").setup()
require("oil").setup()
require("blink.cmp").setup()
require("gitsigns").setup()
require("tiny-inline-diagnostic").setup()

local telescope = require("telescope")
telescope.setup({
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
	}
})
telescope.load_extension("ui-select")

vim.lsp.enable({ "lua_ls" })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
        require('jdtls_setup').setup()
    end
})

vim.cmd("colorscheme bamboo")

require('keymaps')

require("ssh-telescope").setup()
vim.keymap.set("n", "<leader>ss", require("ssh-telescope").ssh_picker, { desc = "SSH Telescope" })

vim.api.nvim_create_user_command('LazyGit', function()
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)

  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = 'minimal',
    border = 'rounded',
  })

  vim.fn.termopen('lazygit', {
    on_exit = function()
      vim.api.nvim_buf_delete(buf, { force = true })
    end,
  })
  vim.cmd('startinsert')
end, {})

vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { desc = 'LazyGit' })

vim.keymap.set('n', '<leader>hn', ':Gitsigns next_hunk<CR>', { desc = 'Gitsigns jump to next hunk' })
vim.keymap.set('n', '<leader>hp', ':Gitsigns next_hunk<CR>', { desc = 'Gitsigns jump to next hunk' })
