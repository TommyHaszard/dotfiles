
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
map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map({ "n" }, "<leader>sg", builtin.live_grep, { desc = 'Telescope live grep' })
map({ "n" }, "<leader>sb", builtin.buffers, { desc = 'Telescope search buffers' })
map({ "n" }, "<leader>si", builtin.grep_string, { desc = 'Telescope grep strings' })
map({ "n" }, "<leader>so", builtin.oldfiles, { desc = 'Telescope find files' })
map({ "n" }, "<leader>sh", builtin.help_tags, { desc = 'Telescope help tags for plugins' })
map({ "n" }, "<leader>sm", builtin.man_pages, { desc = 'Telescope man pages' })
map({ "n" }, "<leader>sr", builtin.lsp_references, { desc = 'Telescope lsp references' })
map({ "n" }, "<leader>sv", builtin.diagnostics, { desc = 'Telescope diagnostics' })
map({ "n" }, "<leader>si", builtin.lsp_implementations, { desc = 'Telescope lsp implementations' })
map({ "n" }, "<leader>st", builtin.lsp_type_definitions, { desc = 'Telescope type definitions' })
map({ "n" }, "<leader>sf", builtin.current_buffer_fuzzy_find, { desc = 'Telescope curr buffer fuzzy find' })
map({ "n" }, "<leader>sT", builtin.builtin, { desc = 'Telescope builtin search' })
map({ "n" }, "<leader>sc", builtin.git_bcommits, { desc = 'Telescope git bcommits' })
map({ "n" }, "<leader>sk", builtin.keymaps, { desc = 'Telescope search keymaps' })
map("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
