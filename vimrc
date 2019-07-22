" ===========================================================================
" .vimrc of Matt Donnelly
" ============================================================================

set nocompatible
filetype plugin indent on

" ============================================================================
" Plugins {{{
" ============================================================================

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

silent! if plug#begin('~/.vim/plugged')

" appearence plugins
Plug 'mattdonnelly/vim-noctu'
Plug 'mattdonnelly/vim-hybrid'
Plug 'mhinz/vim-startify'
Plug 'ayu-theme/ayu-vim'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" integrations
Plug 'junegunn/vim-easy-align'                     " alignment
Plug 'easymotion/vim-easymotion'                   " fast movement
Plug 'airblade/vim-gitgutter'                      " git status
Plug 'tpope/vim-fugitive'                          " git integration
Plug 'christoomey/vim-tmux-navigator'              " tmux + vim pane navigation
Plug 'tpope/vim-surround'                          " easier surronding characters
Plug 'tpope/vim-commentary'                        " quicker commenting
Plug 'ntpeters/vim-better-whitespace'              " strip trailing whitespace
Plug 'junegunn/vim-emoji'                          " emojis
Plug 'ajh17/VimCompletesMe'                        " improved tab completion in insert mode
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' } " visualization of undo history
Plug 'ludovicchabant/vim-gutentags'                " auto update ctags
Plug 'sheerun/vim-polyglot'                        " language packs

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy search
Plug 'junegunn/fzf.vim'

" js
Plug 'othree/yajs.vim', { 'for': 'javascript' } " enhanced js syntax highlighting

" python
Plug 'hdima/python-syntax', { 'for': 'python' }  " improved syntax highlighting
Plug 'tmhedberg/SimpylFold', { 'for': 'python' } " better folding

Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }

" files
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }            " file tree

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

if has('nvim')
  " async auto completion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
else
  " synchronous auto completion
  Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
endif

if filereadable(glob("~/.localplugins.vim"))
  source ~/.localplugins.vim
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

if exists('+termguicolors')
  set termguicolors
endif

try
  let g:vim_monokai_tasty_italic = 1
  colorscheme vim-monokai-tasty
catch
  colorscheme koehler
endtry

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

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

if exists('plugs')
  if has_key(plugs, 'fzf.vim')
    nnoremap <leader>f :Files<CR>
    nnoremap <leader>b :Buffer<CR>
    nnoremap <leader>h :History<CR>
    nnoremap <leader>/ :Ag<CR>

    " let $FZF_DEFAULT_OPTS='--layout=reverse --preview \"(bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -500"'
    let $FZF_DEFAULT_OPTS='--multi --layout=reverse'

    " Augmenting Ag command using fzf#vim#with_preview function
    "   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
    "   * Preview script requires Ruby
    "   * Install Highlight or CodeRay to enable syntax highlighting
    "
    "   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
    "   :Ag! - Start fzf in fullscreen and display the preview window above
    command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \                 <bang>0)

    command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
  endif

  if has_key(plugs, 'lightline.vim')
    set noshowmode
  endif

  if has_key(plugs, 'undotree')
    nnoremap <leader>u :UndotreeToggle<CR>
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

  if has_key(plugs, 'lightline-bufferline')
    autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()
    nmap <Leader>1 <Plug>lightline#bufferline#go(1)
    nmap <Leader>2 <Plug>lightline#bufferline#go(2)
    nmap <Leader>3 <Plug>lightline#bufferline#go(3)
    nmap <Leader>4 <Plug>lightline#bufferline#go(4)
    nmap <Leader>5 <Plug>lightline#bufferline#go(5)
    nmap <Leader>6 <Plug>lightline#bufferline#go(6)
    nmap <Leader>7 <Plug>lightline#bufferline#go(7)
    nmap <Leader>8 <Plug>lightline#bufferline#go(8)
    nmap <Leader>9 <Plug>lightline#bufferline#go(9)
    nmap <Leader>0 <Plug>lightline#bufferline#go(10)
  endif

  if has_key(plugs, 'coc.nvim')
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

    inoremap <silent><expr> <c-space> coc#refresh()

    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)

    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    command! -nargs=0 Prettier :CocCommand prettier.formatFile

    nnoremap <leader>d :CocList diagnostics<CR>

    set signcolumn=auto:2
  endif
endif

" }}}
" ============================================================================
" Settings {{{
" ============================================================================

if !has('nvim')
  set encoding=utf-8
endif

set noautochdir

set showtabline=2
"
" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

set backspace=2
set list listchars=tab:▸\ ,trail:·,nbsp:·,eol:¬ " display extra whitespace

set updatetime=300

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

let g:python_host_prog = $HOME . '/.homebrew/bin/python2'
let g:python3_host_prog = $HOME . '/.homebrew/bin/python3'

let g:lightline = {
  \ 'colorscheme': 'monokai_tasty',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'cocstatus', 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head',
  \   'cocstatus': 'coc#status'
  \ }
  \ }

let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

" }}}
" ============================================================================
" Autocmd {{{
" ============================================================================

augroup vimrcEx
  autocmd!

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
