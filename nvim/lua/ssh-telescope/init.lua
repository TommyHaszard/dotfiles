local M = {}

function M.setup(opts)
	opts = opts or {}

	-- create user command
	vim.api.nvim_create_user_command("SSHTelescope", function()
		require("ssh-telescope.telescope_picker").ssh_picker()
	end, {})
end

M.ssh_picker = function()
	require("ssh-telescope.telescope_picker").ssh_picker()
end

return M
