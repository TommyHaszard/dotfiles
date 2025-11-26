local M = {}
function M:setup()
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	local sep = package.config:sub(1, 1)
	local data_path = vim.fn.stdpath("data")
	local workspace_dir = data_path .. sep .. "jdtls-workspace" .. sep .. project_name
	local os_name = vim.loop.os_uname().sysname
	local arch = vim.loop.os_uname().machine

	vim.fn.mkdir(workspace_dir, "p")

	local jdtls_path = data_path .. sep .. "mason" .. sep .. "packages" .. sep .. "jdtls"
	local lombok_jar = data_path .. sep .. "mason" .. sep .. "packages" .. sep .. "jdtls" .. sep .. "lombok.jar"
	local launcher_jar = vim.fn.glob(jdtls_path .. sep .. "plugins" .. sep .. "org.eclipse.equinox.launcher_*.jar")

	if launcher_jar == "" then
		vim.notify("jdtls launcher jar not found", vim.log.levels.ERROR)
		return
	end

	print("Launcher jar: " .. launcher_jar)
	print("JDTLS Path: " .. jdtls_path)
	print("Config path: " ..
		jdtls_path ..
		package.config:sub(1, 1) ..
		"config_" .. (os_name == "Windows_NT" and "win" or os_name == "Linux" and "linux" or "mac"))

	local config_dir
	if os_name == "Linux" then
		config_dir = arch == "arm64" and "config_linux_arm" or "config_linux"
	elseif os_name == "Darwin" then -- macOS
		config_dir = arch == "arm64" and "config_mac_arm" or "config_mac"
	else
		config_dir = "config_win"
	end

	vim.env.JAVA_HOME = "/opt/homebrew/opt/openjdk@21"
	local root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw", "pom.xml" }, { upward = true })[1])
	local format_file = vim.fn.expand("~/.config/nvim/lua/Default.xml")
	if vim.fn.filereadable(format_file) == 0 then
		vim.notify("Format file not found at: " .. format_file, vim.log.levels.WARN)
	else
		print("Using format file: " .. format_file)
	end

	local bundles = {}

	local java_debug_path = vim.fn.stdpath('data') .. '/mason/packages/java-debug-adapter/extension/server/'
	if vim.fn.isdirectory(java_debug_path) == 1 then
		vim.list_extend(bundles, vim.split(vim.fn.glob(java_debug_path .. '*.jar'), '\n'))
	end

	local java_test_path = vim.fn.stdpath('data') .. '/mason/packages/java-test/extension/server/'
	if vim.fn.isdirectory(java_test_path) == 1 then
		vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. '*.jar'), '\n'))
	end

	local config = {
		cmd = {
			"/opt/homebrew/opt/openjdk@21/bin/java",
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xmx1g",
			"--add-modules=ALL-SYSTEM",
			"--add-opens", "java.base/java.util=ALL-UNNAMED",
			"--add-opens", "java.base/java.lang=ALL-UNNAMED",
			-- CRITICAL: -javaagent MUST come BEFORE -jar
			"-javaagent:" .. lombok_jar,
			"-jar", launcher_jar,
			"-configuration", jdtls_path .. sep .. config_dir,
			"-data", workspace_dir,
		},
		root_dir = root_dir,
		settings = {
			java = {
				jdt = {
					ls = {
						lombokSupport = {
							enabled = true
						}
					}
				},
				format = {
					enabled = true,
					settings = {
						url = "file://" .. format_file,
						profile = "Default",
					},
				},
				configuration = {
					updateBuildConfiguration = "automatic",
				},
			},
		},
		init_options = {
			bundles = bundles,
		},
		on_attach = function(client, bufnr)
			local dap = require('dap')

			dap.configurations.java = {
				{
					type = 'java',
					request = 'launch',
					name = "Debug (Attach) - Remote",
					hostName = "127.0.0.1",
					port = 5005,
				},
				{
					type = 'java',
					request = 'launch',
					name = "Debug",
					mainClass = "${file}",
				},
			}
		end
	}

	print("Full command: " .. table.concat(config.cmd, " "))
	print("Lombok jar: " .. lombok_jar)
	print("Format file: " .. format_file)

	vim.lsp.config("jdtls", config)
end

return M
