
local map = vim.keymap.set

map('n', '<leader>fq', ':%s/^.*$/\'\\0\',/<CR>', {
  desc = 'Format lines for SQL IN clause',
  silent = true
})

map('n', '<leader>o', ':update<CR> :source<CR>')
map('n', '<leader>lf', vim.lsp.buf.format)
-- map('n', '<leader>sd', ':e .<CR>', { desc = 'Open current dir in'})
map({'n', 'v', 'x'}, '<leader>y', '"+y<CR>')
map({'n', 'v', 'x'}, '<leader>p', '"+p<CR>')
map({'n', 'v', 'x'}, '<leader>w', ':update')

map('n', '<leader>ya', 'gg"+yG``', {
  desc = 'Yank entire file to clipboard',
  silent = true
})
