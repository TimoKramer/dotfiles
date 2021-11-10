vim.opt.shadafile = "NONE"

vim.cmd [[highlight Normal ctermbg=16]]
vim.cmd [[let g:vim_better_default_persistent_undo = 1]]
vim.opt.termguicolors = true
vim.opt.background = "light"

require('disable_builtins')
require('plugins')
require('mappings')


vim.opt.background = "light"

vim.opt.shadafile = ""
