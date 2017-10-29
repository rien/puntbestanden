set nocompatible
filetype off

" plug: curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe'
Plug 'blueshirts/darcula'
Plug 'easymotion/vim-easymotion'
Plug 'jceb/vim-orgmode'
Plug 'jiangmiao/auto-pairs'
Plug 'lervag/vimtex'
Plug 'procrat/oz.vim'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'slim-template/vim-slim'
Plug 'takac/vim-hardtime'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-syntastic/syntastic'
Plug 'vim-ruby/vim-ruby'
call plug#end()

set autoread

autocmd FileType markdown set spell spelllang=en_us,nl

" hardtime: break habits
let g:hardtime_default_on = 1
let g:hardtime_showmsg = 1
let g:hardtime_allow_different_key = 1
" Maybe not so hard...
let g:hardtime_timeout = 500
let g:hardtime_maxcount = 5

" easymotion
map <Leader> <Plug>(easymotion-prefix)


noremap J <C-d>
noremap K <C-u>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers = [ 'eslint' ]
let g:syntastic_rust_rustc_exe = 'cargo check'
let g:syntastic_rust_rustc_fname = ''
let g:syntastic_rust_rustc_args = '--'
let g:syntastic_rust_checkers = ['rustc']
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

" Rust
let g:ycm_rust_src_path='/usr/src/rust/src'

filetype plugin indent on

autocmd FileType javascript call WebDevHook()
autocmd FileType less call WebDevHook()
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

