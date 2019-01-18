" tab completion
set wildmode=longest,list,full
set wildmenu
" yaml handling
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" syntax highlighting
syntax on
" special file handlers
au BufRead,BufNewFile *.conf set filetype=icinga2
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
" encoding
set encoding=utf-8
" indenting
filetype plugin indent on
" smartcase search
set smartcase
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" turn line numbering on
set number
" enable pathogen
execute pathogen#infect()
" ctrlP settings
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
" syntastic settings
let g:syntastic_sh_checkers = ['shellcheck']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" base16 shell
let base16colorspace=256  " Access colors present in 256 colorspace
" airline
"set laststatus=2
let g:airline_theme='base16_google'
let g:airline_symbols_ascii = 1
