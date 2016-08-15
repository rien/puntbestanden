set nocompatible
filetype off

" plug: curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'lervag/vimtex'
" Plug 'altercation/vim-colors-solarized'
" Plug 'jpo/vim-railscasts-theme'
Plug 'blueshirts/darcula'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'neomake/neomake'
"Plug 'vim-pandoc/vim-pandoc'
"Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()

set autoread

" Use HJKL
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Persistent undo
set undofile
set undodir=~/.vimundo/

" Other formatting
syntax enable
set background=dark
colorscheme darcula
set number
set linebreak
set expandtab
set tabstop=4
set shiftwidth=4

" Write as root
cmap w!! w !sudo tee > /dev/null %

" Write by pressing escape a lot
map <Esc><Esc> :w<CR>

" Unhighlight highlighted stuff
map <C-s>:noh<CR>

let maplocalleader = '\'

" Latex allow escape
let g:Tex_CompileRule_pdf='pdflatex -interaction=nonstopmode -shell-escape $*'


filetype plugin indent on

autocmd FileType javascript call WebDevHook()
autocmd FileType html call WebDevHook()
autocmd FileType ruby call WebDevHook()
autocmd FileType yaml call WebDevHook()
autocmd FileType eruby call WebDevHook()

function WebDevHook()
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal softtabstop=2
endfunction

" #JustNerdTreeThings
noremap <C-t> :NERDTreeToggle<CR><CR>
let NERDTreeIgnore = ['\.pyc$', '\.hi', '\.o']
let NERDTreeShowHidden=1

