set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on


noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

syntax enable
set background=dark
colorscheme solarized
set number
set linebreak
set expandtab
set tabstop=4
set shiftwidth=4

map <Esc><Esc> :w<CR>
nmap :wl \ll
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
let NERDTreeIgnore = ['\.pyc$', '\.hi', '\.o']
let NERDTreeShowHidden=1

