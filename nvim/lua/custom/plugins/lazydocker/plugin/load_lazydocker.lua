vim.api.nvim_create_user_command('LazyDocker', function()
  package.loaded["lazydocker"] = nil

  require("lazydocker").setup()
end, {})

