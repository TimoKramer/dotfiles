" enable pathogen
execute pathogen#infect()

" show line numbers
set number

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" recommended syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" solarized settings
let g:solarized_termcolors= 256
let g:solarized_visibility= "normal"
set background=light
colorscheme solarized

" omnicompletion
set omnifunc=syntaxcomplete#Complete

" syntax highlighting
syntax enable

filetype plugin indent on
