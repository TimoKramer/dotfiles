if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Clojure
Plug 'liquidz/vim-iced', {'for': 'clojure'}
Plug 'guns/vim-sexp', {'for': 'clojure'}
Plug 'liquidz/vim-iced-coc-source', {'for': 'clojure'}
Plug 'guns/vim-clojure-static', {'for': 'clojure'}
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release', 'for': 'clojure'}

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=1000

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "
let g:mapleader = " "

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! WW w !sudo tee % > /dev/null


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clojure
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:iced_enable_default_key_mappings = v:true
