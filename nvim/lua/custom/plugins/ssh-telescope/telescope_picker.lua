local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local ssh_parser = require("ssh-telescope.ssh_config_parser")

local picker = {}

function picker.ssh_picker(opts)
	opts = opts or {}

	-- get SSH hosts
	local hosts = ssh_parser.parse_ssh_config()

	if #hosts == 0 then
		vim.notify("No SSH hosts found in ~/.ssh/config", vim.log.levels.WARN)
		return
	end

	pickers.new(opts, {
		prompt_title = "SSH Hosts",
		finder = finders.new_table({
			results = hosts,
			entry_maker = function(entry)
				local display = entry.name
				if entry.user then
					display = entry.user .. "@" .. display
				end
				if entry.hostname then
					display = display .. " (" .. entry.hostname .. ")"
				end

				return {
					value = entry,
					display = display,
					ordinal = entry.name,
				}
			end,
		}),
		sorter = conf.generic_sorter(opts),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()

				if selection then
					picker.ssh_connect(selection.value)
				end
			end)
			return true
		end,
	}):find()
end

function picker.ssh_connect(host)
	local ssh_cmd = "ssh " .. host.name
	vim.cmd("tabnew")
	vim.cmd("terminal " .. ssh_cmd)
	vim.cmd("startinsert")
end

return picker
