" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'nvie/vim-flake8'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'google/vim-colorscheme-primary'

call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" tab completion
set wildmode=longest,list,full
set wildmenu
" yaml handling
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" syntax highlighting
syntax enable
" encoding
set encoding=utf-8
" smartcase search
set smartcase
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" turn line numbering on
set relativenumber
" python setup
let python_highlight_all = 1
" mucomplete settings
set completeopt+=menuone
set completeopt+=noselect
set shortmess+=c
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 1
"" youcompleteme settings
"let g:ycm_autoclose_preview_window_after_insertion=1
"let g:ycm_autoclose_preview_window_after_completion=1
" syntastic settings
let g:syntastic_sh_checkers = ['shellcheck']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" theme
set t_Co=256
set background=dark
colorscheme primary
" airline
"set laststatus=2
let g:airline_theme='base16_google'
let g:airline_symbols_ascii = 1

" FZF
set rtp+=~/.fzf

" Commands
" write with sudo rights
"command WW :execute ':silent w !sudo tee % > /dev/null' | :edit!

" remapping escape
cnoremap kj <C-C>
cnoremap jk <C-C>
