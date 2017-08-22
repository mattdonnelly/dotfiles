" ===========================================================================
" .vimrc of Matt Donnelly
" ============================================================================

set nocompatible
filetype plugin indent on

" ============================================================================
" Plugins {{{
" ============================================================================

silent! if plug#begin('~/.vim/plugged')

" appearence plugins
Plug 'mattdonnelly/vim-noctu'
Plug 'mattdonnelly/vim-hybrid'
Plug 'mhinz/vim-startify'
Plug 'ayu-theme/ayu-vim'

" integrations
Plug 'junegunn/vim-easy-align'                     " alignment
Plug 'airblade/vim-gitgutter'                      " git status
Plug 'vim-airline/vim-airline'                     " status line
Plug 'vim-airline/vim-airline-themes'              " themes
Plug 'tpope/vim-fugitive'                          " git integration
Plug 'christoomey/vim-tmux-navigator'              " tmux + vim pane navigation
Plug 'tpope/vim-surround'                          " easier surronding characters
Plug 'tpope/vim-commentary'                        " quicker commenting
Plug 'mattn/emmet-vim'                             " easier html tags
Plug 'ntpeters/vim-better-whitespace'              " strip trailing whitespace
Plug 'w0rp/ale'                                    " linting
Plug 'junegunn/vim-emoji'                          " emojis
Plug 'ajh17/VimCompletesMe'                        " improved tab completion in insert mode
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' } " visualization of undo history

" js
Plug 'othree/yajs.vim', { 'for': 'javascript' } " enhanced js syntax highlighting

" python
Plug 'hdima/python-syntax', { 'for': 'python' }  " improved syntax highlighting
Plug 'tmhedberg/SimpylFold', { 'for': 'python' } " better folding

Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }

" files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy search
Plug 'junegunn/fzf.vim'                                           " fzf vim integration
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }            " file tree

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

if has('nvim')
  " async auto completion
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript', 'do': 'npm install -g tern' }
  Plug 'zchee/deoplete-jedi', { 'for': 'python' }
else
  " synchronous auto completion
  Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
endif

if filereadable(glob("~/.vimplugins.local"))
  source ~/.vimplugins.local
endif

call plug#end()
endif

" }}}
" ============================================================================
" System {{{
" ============================================================================

set clipboard=unnamed

if has("persistent_undo")
  set undodir=~/.vim-undo/
  set undofile
endif

"}}}
" ============================================================================
" Appearence {{{
" ============================================================================

if has("termguicolors")
  set termguicolors
endif

let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

let ayucolor="dark"
colorscheme ayu
" colorscheme noctu

" statusline customization
function! S_modified()
  if !&modifiable || &readonly
    return ' '.emoji#for('lock').' '
  elseif &modified
    return ' '.emoji#for('pencil').' '
  else
    return ''
  endif
endfunction

function! S_fugitive()
  if exists('*figutive#head') && strlen(fugitive#head())
    return fugitive#head()
  else
    return ''
  endif
endfunction

" set statusline=                                                            " clear upon load
" set statusline+=\ %{emoji#available()?emoji#for('cherry_blossom').'\ ':''} " pretty flower
" set statusline+=\ %n:\ %f                                                  " buffer + filename
" set statusline+=%{S_modified()}                                            " modification
" set statusline+=%{strlen(&filetype)?'\ ['.&filetype.']\ ':''}              " file info
" set statusline+=%{S_fugitive()}                                            " git
" set statusline+=%=%-30.(line:\ %l\ of\ %L,\ col:\ %c%V%)                   " position
" set statusline+=\ %P\                                                      " percent

" }}}
" ============================================================================
" Key bindings {{{
" ============================================================================
let mapleader = ' '

nnoremap ; :
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

nnoremap <leader>l :lopen<CR>

nnoremap <C-n> :bprevious<CR>
nnoremap <C-m> :bnext<CR>

if exists('plugs')
  if has_key(plugs, 'fzf.vim')
    nnoremap <leader>f :Files<CR>
    nnoremap <leader>b :Buffer<CR>
    nnoremap <leader>h :History<CR>
    nnoremap <leader>/ :Ag<CR>
  endif

  if has_key(plugs, 'undotree')
    nnoremap U :UndotreeToggle<CR>
  endif

  if has_key(plugs, 'nerdtree')
    nnoremap <leader>n :NERDTreeToggle<CR>
  endif

  if has_key(plugs, 'YouCompleteMe')
    nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
  endif

  if has_key(plugs, 'vim-easy-align')
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
  endif
endif

" }}}
" ============================================================================
" Settings {{{
" ============================================================================

if !has('nvim')
  set encoding=utf-8
endif
"
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

set hidden                 " nicer buffer behaviour
set noswapfile             " no swap files
set autoread               " auto read changes to files
set nu                     " current line number
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

" folding
set foldmethod=indent
set foldlevel=99

" automatic indentation
set autoindent
set smartindent

" soft tabs, 2 spaces
set smarttab
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" }}}
" ============================================================================
" Plugin configuration {{{
" ============================================================================

let g:airline#extensions#tabline#enabled = 1

let g:airline_theme = 'hybridline'
let g:airline_powerline_fonts = 0

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.whitespace = 'Ξ'

let g:python_host_prog = '/Users/mattdonnelly/.homebrew/bin/python'
let g:python3_host_prog = '/Users/mattdonnelly/.homebrew/bin/python3'

let g:ycm_autoclose_preview_window_after_completion = 1

let g:ale_linters = {
\   'javascript': ['standard'],
\}

let g:ale_javascript_standard_use_global = 1

let g:neomake_javascript_enabled_makers = ['standard']
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_python_flake8_maker = {
  \ 'args': ['--max-line-length=120']
  \ }

if has_key(plugs, 'deoplete.nvim')
  " set completeopt-=preview
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_smart_case = 1
  let g:deoplete#auto_completion_start_length = 1
  if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
  endif

  inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
endif

autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

if has_key(plugs, 'tern_for_vim')
  let g:tern_request_timeout = 1
  let g:tern_show_argument_hints = 'on_hold'
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif

" }}}
" ============================================================================
" Autocmd {{{
" ============================================================================

augroup vimrcEx
  autocmd!

  " autocmd! BufWritePost * Neomake

  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

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
  autocmd FileType python,actionscript setlocal
    \ expandtab
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4

  " allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-

  autocmd FileType markdown setlocal formatoptions=ant textwidth=119 wrapmargin=0

  autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
augroup END

" }}}
" ============================================================================
" vim: fdm=marker:sw=2:sts=2:et
