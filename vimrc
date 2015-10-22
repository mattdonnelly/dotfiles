set nocompatible
filetype plugin indent on
syntax on

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" appearence plugins
Plug 'mattdonnelly/vim-hybrid'    " theme
Plug 'bling/vim-airline'          " status line theme
Plug 'mhinz/vim-startify'         " helpful start page

" integrations
Plug 'Lokaltog/vim-easymotion'        " movement without numbers
Plug 'rking/ag.vim'                   " ag integration
Plug 'airblade/vim-gitgutter'         " git status
Plug 'tpope/vim-fugitive'             " git integration
Plug 'christoomey/vim-tmux-navigator' " tmux + vim pane navigation
Plug 'tpope/vim-surround'             " easier surronding characters
Plug 'tpope/vim-commentary'           " commenting
Plug 'mattn/emmet-vim'                " easier html tags

Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }     " fuzzy search
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeFocus' } " file tree
Plug 'Valloric/YouCompleteMe', { 'for': 'cpp', 'do': './install.sh --clang-complete' } " code compeltion

call plug#end()

set encoding=utf-8  " allow rich text


let g:hybrid_use_Xresources = 1
set background=dark " dark background
colorscheme hybrid  " set syntax colouring theme

set viminfo='100,n$HOME/.vim/files/info' " set viminfo

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

augroup vimrcEx
    autocmd!

    " when editing a file, always jump to the last known cursor position.
    " don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

    " set syntax hilighting
    autocmd BufRead,BufNewFile *.md set filetype=markdown

    " strip white space
    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

    " allow stylesheets to autocomplete hyphenated words
    autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" The Silver Searcher
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

" bind \ (backward slash) to grep shortcut
nnoremap \ :Ag<SPACE>
nnoremap <C-P> :FZF<CR>

let mapleader=" "

nmap <leader>q <plug>(QuickScopeToggle)
vmap <leader>q <plug>(QuickScopeToggle)

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

set backspace=2
set list listchars=tab:▸\ ,trail:·,nbsp:·,eol:¬ " display extra whitespace

" When the page starts to scroll, keep the cursor 8 lines from the top
" and 8 lines from the bottom and 15 lines on the left
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

set noswapfile             " no swap files
set autoread               " auto read changes to files
set relativenumber         " relative line numbers
set numberwidth=3          " gutter width
set whichwrap+=<,>,h,l,[,] " cursor line wrapping
set nohlsearch             " don't highlight search results
set incsearch              " incremental search
set ignorecase             " ignore search case
set smartcase              " smart search matching case
set ruler                  " show the cursor position all the time
set laststatus=2           " always display the status line
set nowrap                 " no word wrapping
set linebreak              " only insert linebreaks explicitly
set mouse=a                " allow mouse scrolling

" soft tabs, 4 space
set tabstop=4
set shiftwidth=4
set expandtab

" use 2 space for js
autocmd Filetype javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2

" automatic indentation
set autoindent
set smartindent

nnoremap ; :
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

nmap <silent> <C-n> :NERDTreeFocus<cr>

let g:ctrlp_working_path_mode = 0

let g:airline_theme = 'hybrid'
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:airline#extensions#branch#enabled=1

let g:airline#syntastic#enabled=1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -Wall'
