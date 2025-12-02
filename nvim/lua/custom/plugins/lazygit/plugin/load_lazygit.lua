vim.api.nvim_create_user_command('LazyGit', function()
  package.loaded["lazygit"] = nil

  require("lazygit").setup()
end, {})

