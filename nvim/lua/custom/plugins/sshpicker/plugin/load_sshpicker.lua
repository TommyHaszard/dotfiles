vim.api.nvim_create_user_command('SSHPicker', function()
  package.loaded["sshpicker"] = nil

  require("sshpicker").ssh_picker()
end, {})

