local map = vim.api.nvim_set_keymap

vim.g.mapleader = ","
vim.g.maplocalleader = ","

map('n', '<Leader>ff', '<Cmd>:Telescope find_files<CR>', { noremap=true, silent=true })
map('n', '<Leader>fg', '<Cmd>:Telescope live_grep<CR>', { noremap=true, silent=true })
map('n', '<Leader>fb', '<Cmd>:Telescope buffers<CR>', { noremap=true, silent=true })
map('n', '<Leader>fh', '<Cmd>:Telescope help_tags<CR>', { noremap=true, silent=true })
map('n', '<Leader><CR>', ':noh<CR>', { noremap=true, silent=true })
