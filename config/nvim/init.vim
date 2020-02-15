set nocompatible
filetype off

" plug: curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')
Plug 'Glench/vim-jinja2-syntax'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'andys8/vim-elm-syntax'
Plug 'purescript-contrib/purescript-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'blueshirts/darcula'
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'procrat/oz.vim'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'slim-template/vim-slim'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
"Plug 'vim-syntastic/syntastic'
Plug 'vim-ruby/vim-ruby'
Plug 'rhysd/vim-crystal'
Plug 'eagletmt/neco-ghc'
Plug 'eagletmt/ghcmod-vim'
Plug 'isRuslan/vim-es6'
Plug 'sebastianmarkow/deoplete-rust'
"Plug 'leafgarland/typescript-vim'
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'
Plug 'junegunn/fzf'
Plug 'LnL7/vim-nix'

if has('nvim')
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  "Plug 'Shougo/denite.nvim'
endif

call plug#end()

set autoread

autocmd FileType mail call Text()
autocmd FileType markdown call Text()
autocmd FileType tex call Text()
autocmd FileType gitcommit call Text()
autocmd FileType mail set colorcolumn=72


function Text()
    set spell spelllang=en_us,nl
    "set formatoptions+=a " Automatic wrapping & unwrapping
    set formatoptions+=n " Keep list alignment
    set formatoptions+=1 " Prefer to wrap before single character words
endfunction

function ToggleFlag(option,flag)
  exec ('let lopt = &' . a:option)
  if lopt =~ (".*" . a:flag . ".*")
    exec ('set ' . a:option . '-=' . a:flag)
  else
    exec ('set ' . a:option . '+=' . a:flag)
  endif
endfunction

" Toggle automatic wrapping & unwrapping
map <Leader> <a> :call ToggleFlag("formatoptions","a")<CR>

" easymotion
map <Leader> <Plug>(easymotion-prefix)

" Go to the next warning or error
map <C-a> :ALENext<CR>

noremap J <C-d>
noremap K <C-u>

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_haskell_checkers = ['hlint', 'ghc_mod']
" let g:syntastic_ruby_checkers = ['rubocop']
" let g:syntastic_javascript_checkers = [ 'eslint' ]
" let g:syntastic_typescript_checkers = [ 'eslint' ]
" map <C-c> :SyntasticToggleMode<CR>
"


let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
            \   'right': [ [ 'linter_checking', 'linter_errors',
            \                'linter_warnings', 'linter_ok' ],
            \              [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'fileformat', 'fileencoding', 'filetype' ]
            \            ],
            \ },
            \ 'component_function': {
            \   'gitbranch': 'fugitive#head'
            \ },
            \ 'component_expand': {
            \   'linter_checking': 'lightline#ale#checking',
            \   'linter_warnings': 'lightline#ale#warnings',
            \   'linter_errors': 'lightline#ale#errors',
            \   'linter_ok': 'lightline#ale#ok',
            \ },
            \ 'component_type': {
            \    'linter_checking': 'left',
            \    'linter_warnings': 'warning',
            \    'linter_errors': 'error',
            \    'linter_ok': 'left',
            \ },
            \ }

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
set expandtab
set tabstop=4
set shiftwidth=4
set colorcolumn=80

" Allow project-specific .vimrc files, but disable unsafe commands
set exrc
set secure

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
"autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

"let g:ghcmod_use_basedir="/home/rien/.vim/scripts/"

" Let <Tab> also do completion
" inoremap <silent><expr> <TAB>
"     \ pumvisible() ? "\<C-n>" :
"     \ <SID>check_back_space() ? "\<TAB>" :
"     \ deoplete#mappings#manual_complete()
" function! s:check_back_space() abort "{{{
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1]  =~ '\s'
" endfunction"}}}

" Language Server config

set hidden

" Rust
" let g:ycm_rust_src_path='/usr/src/rust/src'
"let g:deoplete#sources#rust#racer_binary='~/.cargo/bin/racer'
" set completeopt-=preview

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
autocmd FileType typescript call TwoSpaces()

autocmd FileType ansible set syntax=yaml

function TwoSpaces()
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal softtabstop=2
endfunction

" #JustNerdTreeThings
noremap <C-t> :NERDTreeToggle<CR><CR>
let NERDTreeIgnore = ['\.pyc$', '\.hi', '\.o']
let NERDTreeShowHidden=1

