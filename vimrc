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

" integrations
Plug 'airblade/vim-gitgutter'                      " git status
Plug 'tpope/vim-fugitive'                          " git integration
Plug 'christoomey/vim-tmux-navigator'              " tmux + vim pane navigation
Plug 'tpope/vim-surround'                          " easier surronding characters
Plug 'tpope/vim-commentary'                        " quicker commenting
Plug 'mattn/emmet-vim'                             " easier html tags
Plug 'pangloss/vim-javascript'                     " enhanced js syntax highlighting and indentation
Plug 'ntpeters/vim-better-whitespace'              " strip trailing whitespace
Plug 'benekastah/neomake'                          " linting
Plug 'junegunn/vim-emoji'                          " emojis
Plug 'ajh17/VimCompletesMe'                        " improved tab completion in insert mode
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' } " visualization of undo history

" python
Plug 'hdima/python-syntax', { 'for': 'python' }  " improved syntax highlighting
Plug 'tmhedberg/SimpylFold', { 'for': 'python' } " better folding

" files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy search
Plug 'junegunn/fzf.vim'                                           " fzf vim integration
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeFocus' }             " file tree

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

" synchronous auto completion
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

if filereadable("~/.vimplugins.local")
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

set background=dark
colorscheme noctu

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

set statusline=                                                            " clear upon load
set statusline+=\ %{emoji#available()?emoji#for('cherry_blossom').'\ ':''} " pretty flower
set statusline+=\ %n:\ %f                                                  " buffer + filename
set statusline+=%{S_modified()}                                            " modification
set statusline+=%{strlen(&filetype)?'\ ['.&filetype.']\ ':''}              " file info
set statusline+=%{S_fugitive()}                                            " git
set statusline+=%=%-30.(line:\ %l\ of\ %L,\ col:\ %c%V%)                   " position
set statusline+=\ %P\                                                      " percent

" }}}
" ============================================================================
" Key bindings {{{
" ============================================================================

nnoremap ; :
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

nnoremap <leader>l :lopen<CR>
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
    nmap <silent> <C-n> :NERDTreeFocus<cr>
  endif

  if has_key(plugs, 'YouCompleteMe')
    map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
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

let g:ycm_autoclose_preview_window_after_completion = 1

let g:neomake_python_enabled_makers     = ['flake8']
let g:neomake_javascript_enabled_makers = ['standard']

" }}}
" ============================================================================
" Autocmd {{{
" ============================================================================

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
  autocmd Filetype python setlocal
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4

  " allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" }}}
" ============================================================================
" vim: fdm=marker:sw=2:sts=2:et
