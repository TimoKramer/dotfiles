vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Exit input mode' })
vim.keymap.set('n', '<Leader>ww', ':write<CR>', { desc = 'write file' })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<Leader><CR>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
-- [d and ]d are built-in in nvim 0.11+ (via vim.diagnostic.jump)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', 'jj', '<Esc>', { desc = 'Exit terminal mode' })
