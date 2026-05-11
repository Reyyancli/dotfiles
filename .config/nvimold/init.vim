set number 
set relativenumber
set tabstop=4
set shiftwidth=4
set autoindent
set mouse=a


call plug#begin()

Plug 'https://github.com/vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/lambdalisue/vim-suda'

call plug#end()

let g:airline_powerline_fonts = 1
let g:airline_theme='base16_material_darker'

