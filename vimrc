set nocompatible
filetype plugin indent on
set encoding=utf-8

silent! if plug#begin('~/.vim/plugged')

" appearence plugins
Plug 'mattdonnelly/vim-noctu'     " theme
Plug 'mattdonnelly/vim-hybrid'    " theme
" Plug 'bling/vim-airline'          " status line theme
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
Plug 'ntpeters/vim-better-whitespace' " strip trailing whitespace
Plug 'benekastah/neomake'             " linting
Plug 'nvie/vim-flake8'                " python linter
Plug 'junegunn/vim-emoji'             " emojis
Plug 'ervandew/supertab'              " improved tab completion in insert mode
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle'   }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy search
Plug 'junegunn/fzf.vim'                                           " fzf vim integration
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeFocus' }             " file tree

if has('nvim')
  Plug 'Shougo/deoplete.nvim' " asynchronous auto completion.
else
  function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
      !./install.py
    endif
  endfunction

  " synchronous auto completion
  Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
endif

if filereadable("~/.vimplugins.local")
  source ~/.vimplugins.local
endif

call plug#end()
endif

set clipboard=unnamed

if has("persistent_undo")
  set undodir=~/.vim-undo/
  set undofile
endif

let mapleader=" "

set background=dark
colorscheme noctu

set statusline=                                                                                " clear upon load
set statusline+=\ %{emoji#available()?emoji#for('cherry_blossom').'\ ':''}                     " pretty flower
set statusline+=\ %n:\ %F                                                                      " buffer + filename
set statusline+=\ %m%r%y                                                                       " file info
set statusline+=\ %{exists('*fugitive#head')&&''!=fugitive#head()?'('.fugitive#head().')':''}  " git
set statusline+=%=%-30.(line:\ %l\ of\ %L,\ col:\ %c%V%)                                       " position
set statusline+=\ %P\                                                                          " percent

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
nnoremap <leader>/ :Ag<SPACE>

if exists('plugs') && has_key(plugs, 'fzf.vim')
  nnoremap <C-P> :Files<CR>
  nnoremap <C-O> :Buffer<CR>
  nnoremap <C-S> :History<CR>
endif

nnoremap U :UndotreeToggle<CR>

if exists('plugs') && has_key(plugs, 'neocomplete.vim')
  let g:neocomplete#enable_at_startup = 1 " Enable neocomplete on startup.
  let g:neocomplete#enable_smart_case = 1 " Enable smart case.


  inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"

  " On backspace, delete previous completion and regenerate popup.
  inoremap <expr><C-H> deoplete#mappings#smart_close_popup()."\<C-H>"
  inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-H>"
endif

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

" soft tabs, 2 space
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab

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
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

let g:airline#syntastic#enabled=1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1

let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -Wall'

let g:syntastic_javascript_checkers = ['standard']
