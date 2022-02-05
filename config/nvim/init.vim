" =============================================
" .vimrc of Matt Donnelly
" ============================================================================

set nocompatible
filetype plugin indent on

" ============================================================================
" Plugins {{{
" ============================================================================

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

source ~/.config/nvim/plugins.vim

" }}}
" ============================================================================
" System {{{
" ============================================================================

set noshowmode

set clipboard=unnamed

if has("persistent_undo")
  set undodir=~/.vim-undo/
  set undofile
endif

"}}}
" ============================================================================
" Appearence {{{
" ============================================================================

let &t_ZM = "\e[3m"

if exists('+termguicolors')
  set termguicolors
endif

try
  let g:tokyonight_style = "night"
  let g:tokyonight_italic_functions = 1
  colorscheme tokyonight
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

nnoremap gn :bn<cr>
nnoremap gp :bp<cr>
nnoremap gd :bd<cr>

if exists('plugs')
  if has_key(plugs, 'nvim-lspconfig')
    lua require('lsp')
  endif

  if has_key(plugs, 'telescope.nvim')
    lua require('plugins.telescope')
  endif

  if has_key(plugs, 'vim-test')
    map <Leader>t :TestFile<CR>
    map <Leader>s :TestNearest<CR>
    map <Leader>l :TestLast<CR>
    let test#strategy = {
      \ 'nearest': 'floaterm',
      \ 'file':    'floaterm',
      \ 'suite':   'basic',
      \}
  endif

  if has_key(plugs, 'jumpwire.nvim')
    noremap <leader>mt :lua require('jumpwire').jump('test')<CR>
    noremap <leader>mi :lua require('jumpwire').jump('implementation')<CR>
    noremap <leader>mm :lua require('jumpwire').jump('markup')<CR>
    noremap <leader>ms :lua require('jumpwire').jump('style')<CR>
  endif

  if has_key(plugs, 'undotree')
    nnoremap <leader>u :UndotreeToggle<CR>
  endif

  if has_key(plugs, 'barbar.nvim')
    let bufferline = get(g:, 'bufferline', {})
    let bufferline.clickable = v:true
  endif

  if has_key(plugs, 'gitsigns.nvim')
    lua require('gitsigns').setup()
  endif

  if has_key(plugs, 'nvim-treesitter')
    lua require('plugins.nvim-treesitter')
  endif

  if has_key(plugs, 'nvim-tree.lua')
    lua require('plugins.nvim-tree')
  endif

  if has_key(plugs, 'nvim-autopairs')
    lua require('plugins.nvim-autopairs')
  end

  if has_key(plugs, 'indent-blankline.nvim')
    lua require('plugins.indent-blankline')
  endif

  if has_key(plugs, 'nvim-ts-autotag')
    lua require('nvim-ts-autotag').setup()
  endif

  if has_key(plugs, 'feline.nvim')
    lua require('plugins.feline')
  endif

  if has_key(plugs, 'nvim-web-devicons')
    lua require('plugins.nvim-web-devicons')
  endif

  if has_key(plugs, 'lightspeed.nvim')
    lua require('plugins.lightspeed')
  endif

  if has_key(plugs, 'Comment.nvim')
    lua require('Comment').setup()
  end

  if has_key(plugs, 'dashboard-nvim')
    lua require('plugins.dashboard')
  end

  if has_key(plugs, 'trouble.nvim')
    lua require('plugins.trouble')
  end
endif

" }}}
" ============================================================================
" Settings {{{
" ============================================================================

set encoding=utf-8

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
set sidescroll=8

set hidden                 " nicer buffer behaviour
set nobackup
set nowritebackup
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

let g:python_host_prog = system('echo -n $(brew --prefix)') . '/bin/python'
let g:python3_host_prog = system('echo -n $(brew --prefix)') . '/bin/python3'

let g:any_jump_search_prefered_engine = 'rg'
let g:any_jump_references_enabled = 0

" }}}
" ============================================================================
" Autocmd {{{
" ============================================================================

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

  " allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END
" }}}

if filereadable(glob("~/.config/nvim/init.local.vim"))
  source ~/.config/nvim/init.local.vim
endif

" ============================================================================
" vim: fdm=marker:sw=2:sts=2:et
