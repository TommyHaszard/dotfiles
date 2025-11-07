local ssh_parser = {}

function ssh_parser.parse_ssh_config()
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

return ssh_parser
