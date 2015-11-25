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
Plug 'noahfrederick/vim-noctu'    " theme
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
Plug 'pangloss/vim-javascript'        " enhanced js syntax highlighting and indentation
Plug 'ntpeters/vim-better-whitespace' " stip trailing whitespace
Plug 'benekastah/neomake'             " linting
Plug 'nvie/vim-flake8'                " python linter

Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }     " fuzzy search
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeFocus' } " file tree

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'for': ['cpp', 'python'], 'do': function('BuildYCM') } " code compeltion

if filereadable("~/.vimplugins.local")
    source ~/.vimplugins.local
endif

call plug#end()

set encoding=utf-8  " allow rich text
set clipboard=unnamed

let g:hybrid_use_Xresources = 1
set background=dark " dark background
colorscheme noctu " set syntax colouring theme

augroup vimrcEx
    autocmd!

    autocmd! BufWritePost * Neomake

    " when editing a file, always jump to the last known cursor position.
    " don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

    " set syntax hilighting
    autocmd BufRead,BufNewFile *.md set filetype=markdown

    autocmd FileType python highlight Excess ctermbg=Red
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap

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

set hidden
set noswapfile             " no swap files
set autoread               " auto read changes to files
set nu                     " current line number
set relativenumber         " relative line numbers
set numberwidth=4          " gutter width
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
autocmd Filetype javascript, html, css setlocal
    \ tabstop=2
    \ softtabstop=2
    \ shiftwidth=2

autocmd Filetype python setlocal
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4
    \ textwidth=79
    \ expandtab
    \ autoindent
    \ fileformat=unix

" automatic indentation
set autoindent
set smartindent

nnoremap ; :
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

nmap <silent> <C-n> :NERDTreeFocus<cr>

nmap <leader>t :enew<CR>

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>

let g:ctrlp_working_path_mode = 0

let g:airline_theme = 'hybrid'
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#fnamemod = ':t'

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

let g:airline#syntastic#enabled=1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1

let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -Wall'

let g:syntastic_javascript_checkers = ['standard']
