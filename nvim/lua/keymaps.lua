
local map = vim.keymap.set

map('n', '<leader>fq', ':%s/^.*$/\'\\0\',/<CR>', {
  desc = 'Format lines for SQL IN clause',
  silent = true
})

map('n', '<leader>o', ':update<CR> :source<CR>')
map('n', '<leader>lf', vim.lsp.buf.format)
map('n', '<leader>sd', ':e .<CR>', { desc = 'Open current dir in'})
map({'n', 'v', 'x'}, '<leader>y', '"+y<CR>')
map({'n', 'v', 'x'}, '<leader>p', '"+p<CR>')
map({'n', 'v', 'x'}, '<leader>w', ':update')

map('n', '<leader>ya', 'gg"+yG``', {
  desc = 'Yank entire file to clipboard',
  silent = true
})

local builtin = require('telescope.builtin')
map('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
map({ "n" }, "<leader>g", builtin.live_grep)
map({ "n" }, "<leader>sb", builtin.buffers)
map({ "n" }, "<leader>si", builtin.grep_string)
map({ "n" }, "<leader>so", builtin.oldfiles)
map({ "n" }, "<leader>sh", builtin.help_tags)
map({ "n" }, "<leader>sm", builtin.man_pages)
map({ "n" }, "<leader>sr", builtin.lsp_references)
map({ "n" }, "<leader>sv", builtin.diagnostics)
map({ "n" }, "<leader>si", builtin.lsp_implementations)
map({ "n" }, "<leader>st", builtin.lsp_type_definitions)
map({ "n" }, "<leader>sf", builtin.current_buffer_fuzzy_find)
map({ "n" }, "<leader>sT", builtin.builtin)
map({ "n" }, "<leader>sc", builtin.git_bcommits)
map({ "n" }, "<leader>sk", builtin.keymaps)
