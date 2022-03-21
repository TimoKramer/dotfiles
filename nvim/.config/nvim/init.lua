vim.opt.shadafile = "NONE"

vim.cmd [[highlight Normal ctermbg=16]]
vim.cmd [[let g:vim_better_default_persistent_undo = 1]]

require('plugins')
require('mappings')
require('settings')

vim.opt.shadafile = ""
