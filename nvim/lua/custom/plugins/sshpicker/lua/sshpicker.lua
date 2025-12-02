local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local M = {}

local function parse_ssh_config()
	local ssh_config_path = vim.fn.expand("~/.ssh/config")
	local hosts = {}
	local current_host = nil

	if vim.fn.readfile(ssh_config_path) == 0 then
		return hosts
	end

	local lines = vim.fn.readfile(ssh_config_path)

	for _, line in ipairs(lines) do
		-- whitespace removal
		line = line:match("^%s*(.-)%s*$")

		-- skip comments and empty lines
		if line ~= "" and not line:match("^#") then
			-- match Host entries
			local host = line:match("^[Hh]ost%s+(.+)$")
			if host then
				-- Ignore wildcards
				if not host:match("[*?]") then
					current_host = {
						name = host,
						hostname = nil,
						user = nil,
						port = 22,
					}
					table.insert(hosts, current_host)
				else
					current_host = nil
				end
			elseif current_host then
				-- parse
				local hostname = line:match("[Hh]ost[Nn]ame%s+(.+)$")
				if hostname then
					current_host.hostname = hostname
				end

				local user = line:match("^[Uu]ser%s+(.+)$")
				if user then
					current_host.user = user
				end

				local port = line:match("^[Pp]ort%s+(%d+)$")
				if port then
					current_host.port = tonumber(port)
				end
			end
		end
	end

	return hosts
end


function M.ssh_picker(opts)
	opts = opts or {}

	-- get SSH hosts
	local hosts = parse_ssh_config()

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
					M.ssh_connect(selection.value)
				end
			end)
			return true
		end,
	}):find()
end

function M.ssh_connect(host)
	local ssh_cmd = "ssh " .. host.name
	vim.cmd("tabnew")
	vim.cmd("terminal " .. ssh_cmd)
	vim.cmd("startinsert")
end

return M
