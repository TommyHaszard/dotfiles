local M = {}
function M:setup()
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	local workspace_dir = vim.fn.stdpath("data") ..
			package.config:sub(1, 1) .. "jdtls-workspace" .. package.config:sub(1, 1) .. project_name
	local os_name = vim.loop.os_uname().sysname
	local arch = vim.loop.os_uname().machine
	-- Create workspace directory
	vim.fn.mkdir(workspace_dir, "p")
	local sep = package.config.sub(1, 1)

	local jdtls_path = vim.fn.stdpath("data") .. sep .. "mason" .. sep .. "packages" .. sep .. "jdtls"
	local launcher_jar = vim.fn.glob(jdtls_path ..
		sep .. "plugins" .. sep .. "org.eclipse.equinox.launcher_*.jar")

	if launcher_jar == "" then
		vim.notify("jdtls launcher jar not found", vim.log.levels.ERROR)
		return
	end

	print("Launcher jar: " .. launcher_jar)
  print("JDTLS Path: " .. jdtls_path)
	print("Config path: " .. jdtls_path .. package.config:sub(1,1) .. "config_" .. (os_name == "Windows_NT" and "win" or os_name == "Linux" and "linux" or "mac"))

	local config_dir
	if os_name == "Linux" then
		config_dir = arch == "arm64" and "config_linux_arm" or "config_linux"
	elseif os_name == "Darwin" then -- macOS
		config_dir = arch == "arm64" and "config_mac_arm" or "config_mac"
	else
		config_dir = "config_win"
	end

	vim.env.JAVA_HOME = "/opt/homebrew/opt/openjdk@21"
	local root_dir = vim.fs.dirname(vim.fs.find({"gradlew", ".git", "mvnw", "pom.xml"}, { upward = true })[1])
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
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",
			"-jar",
			launcher_jar,
			"-configuration",
			jdtls_path .. sep .. config_dir,
			"-data",
			workspace_dir,
			'-javaagent:' .. vim.fn.stdpath("data") .. sep .. "mason" .. sep .. "packages" .. sep .. "jdtls" .. sep .. "lombok.jar",
		},
		root_dir = root_dir,
		settings = {
			java = {
				format = {
					enabled = true,
					settings = {
						url = vim.fn.expand("~/.config/nvim/lua/Default.xml"),
						profile = "Default",
					},
				},
			},
		},
		init_options = {
			bundles = {},
		},
	}
	print("Full command: " .. table.concat(config.cmd, " "))
  require("jdtls").start_or_attach(config)
end

return M
