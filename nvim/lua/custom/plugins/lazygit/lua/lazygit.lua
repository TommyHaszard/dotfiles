local lazygit = {}

function lazygit.setup()
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
end

return lazygit
