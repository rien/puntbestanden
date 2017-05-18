set nocompatible
filetype off

" plug: curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'lervag/vimtex'
Plug 'blueshirts/darcula'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'takac/vim-hardtime'
Plug 'easymotion/vim-easymotion'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-syntastic/syntastic'
Plug 'slim-template/vim-slim'
Plug 'procrat/oz.vim'
call plug#end()

set autoread

autocmd FileType markdown set spell spelllang=en_us,nl

" hardtime: break habits
"let g:hardtime_default_on = 1
"let g:hardtime_showmsg = 1
"let g:hardtime_allow_different_key = 1

" easymotion
map <Leader> <Plug>(easymotion-prefix)
let g:syntastic_ruby_checkers = ['rubocop']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
map <C-c> :SyntasticToggleMode<CR>

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
set showcmd
set autoread
set scrolloff=8
set linebreak
set expandtab
set tabstop=4
set shiftwidth=4

" display tabs with a leading \cdot
" trailing whitespace looks like \cdot
set list
set listchars=tab:·\ ,trail:·

" Write as root
cmap w!! w !sudo tee > /dev/null %

" Write by pressing escape a lot
map <Esc><Esc> :w<CR>

" Unhighlight highlighted stuff
map <C-s> :noh<CR>

if has('nvim')
    " Command substitution: see 'live' what will be changed
    set inccommand=split
endif

" Copy/paste with X11 CLIPBOARD
set clipboard=unnamedplus

let mapleader = '\'

" Latex
let g:tex_flavor='latex'
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

