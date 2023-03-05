local map = vim.api.nvim_set_keymap
local options = { noremap=true, silent=true }

vim.g.mapleader = ","
vim.g.maplocalleader = ","

map('n', '<Leader>ff', '<Cmd>:Telescope find_files<CR>', options)
map('n', '<Leader>fg', '<Cmd>:Telescope live_grep<CR>', { noremap=true, silent=true })
map('n', '<Leader>fb', '<Cmd>:Telescope buffers<CR>', { noremap=true, silent=true })
map('n', '<Leader>fh', '<Cmd>:Telescope help_tags<CR>', { noremap=true, silent=true })
map('n', '<Leader><CR>', ':noh<CR>', { noremap=true, silent=true })
map('n', '<Leader>w', ':write<CR>', { noremap=true, silent=true })
--
-- Formatting

map('n', '<Leader>jj', ':%!jet --from json --to json --pretty', { noremap=true, silent=true })
map('n', '<Leader>je', ':%!jet --from edn --to edn --pretty', { noremap=true, silent=true })

-- Terminal

map('i', 'jj', "<Esc>", options)
map('t', 'jj', [[<C-\><C-n>]], options)

-- Command
map('c', '<C-F>', '<Right>', options)
map('c', '<C-B>', '<Left>', options)

--
-- function _G.lsp_formatexr()
--   vim.lsp.buf.range_formatting({}, { vim.v.lnum, 0 }, { vim.v.lnum + vim.v.count, 0 })
--   return 0
-- end
--
-- if client.resolved_capabilities.document_range_formatting then
--   vim.bo.formatexpr = 'v:lua.lsp_formatexr()'
-- end
--
