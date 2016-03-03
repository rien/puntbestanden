set nocompatible
filetype off

" plug: curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'altercation/vim-colors-solarized'
" Plug 'jpo/vim-railscasts-theme'
Plug 'blueshirts/darcula'

call plug#end()

" Use HJKL
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

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

" Write and run pdflatex
nmap :wl \ll

" Same, but with F12
imap <F12> <Esc>:w<CR>\ll


filetype plugin indent on
set grepprg=grep\ -H\ $*
let g:tex_flavor = "pdflatex"
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRuleComplete_pdf = 'xdg-open $*.pdf 2>&1 > /dev/null &'
let g:Tex_MultipleCompileFormats='pdf, aux'
noremap <C-t> :NERDTreeToggle<CR><CR>

autocmd FileType javascript call JavaScriptHook()

function JavaScriptHook()
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal softtabstop=2
endfunction

" #JustNerdTreeThings
let NERDTreeIgnore = ['\.pyc$', '\.hi', '\.o']
let NERDTreeShowHidden=1

