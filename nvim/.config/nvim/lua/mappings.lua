local map = vim.api.nvim_set_keymap
local options = { noremap=true, silent=true }

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Editor

map('n', '<Leader>ff', '<Cmd>:Telescope find_files<CR>', options)
map('n', '<Leader>fg', '<Cmd>:Telescope live_grep<CR>', options)
map('n', '<Leader>fb', '<Cmd>:Telescope buffers<CR>', options)
map('n', '<Leader>fh', '<Cmd>:Telescope help_tags<CR>', options)
map('n', '<Leader><CR>', ':noh<CR>', options)
map('n', '<Leader>w', ':write<CR>', options)

map('n', '<A-k>', '<Cmd>:move .-2<CR>', options)
map('n', '<A-j>', '<Cmd>:move .+1<CR>', options)

-- Terminal
map('i', 'jj', "<Esc>", options)
map('t', 'jj', [[<C-\><C-n>]], options)

-- Command
map('c', '<C-F>', '<Right>', options)
map('c', '<C-B>', '<Left>', options)
