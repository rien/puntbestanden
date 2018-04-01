set nocompatible
filetype off

" plug: curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')

Plug 'dhruvasagar/vim-table-mode'
" Plug 'Valloric/YouCompleteMe'
Plug 'blueshirts/darcula'
Plug 'easymotion/vim-easymotion'
Plug 'jceb/vim-orgmode'
Plug 'jiangmiao/auto-pairs'
Plug 'lervag/vimtex'
Plug 'procrat/oz.vim'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'slim-template/vim-slim'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-syntastic/syntastic'
Plug 'vim-ruby/vim-ruby'
Plug 'rhysd/vim-crystal'
Plug 'eagletmt/neco-ghc'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'eagletmt/ghcmod-vim'
Plug 'isRuslan/vim-es6'


if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()

set autoread

autocmd FileType markdown set spell spelllang=en_us,nl
autocmd FileType tex set spell spelllang=en_us,nl

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
let g:syntastic_haskell_checkers = ['hlint', 'ghc_mod']
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

" Deoplete
let g:deoplete#enable_at_startup = 1

" == Haskell ==
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

" Disable haskell-vim omnifunc
let g:necoghc_use_stack = 1
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

"let g:ghcmod_use_basedir="/home/rien/.vim/scripts/"

" Let <Tab> also do completion
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}



" Rust
let g:ycm_rust_src_path='/usr/src/rust/src'

filetype plugin indent on

autocmd FileType javascript call TwoSpaces()
autocmd FileType less call TwoSpaces()
autocmd FileType css call TwoSpaces()
autocmd FileType scss call TwoSpaces()
autocmd FileType html call TwoSpaces()
autocmd FileType ruby call TwoSpaces()
autocmd FileType yaml call TwoSpaces()
autocmd FileType eruby call TwoSpaces()
autocmd FileType haskell call TwoSpaces()
autocmd FileType json call TwoSpaces()
autocmd FileType crystal call TwoSpaces()

function TwoSpaces()
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal softtabstop=2
endfunction

" #JustNerdTreeThings
noremap <C-t> :NERDTreeToggle<CR><CR>
let NERDTreeIgnore = ['\.pyc$', '\.hi', '\.o']
let NERDTreeShowHidden=1

