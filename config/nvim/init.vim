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

nnoremap <C-n> :BufferPrevious<CR>
nnoremap <C-m> :BufferNext<CR>

if exists('plugs')
  if has_key(plugs, 'nvim-lspconfig')
    lua require('lsp')
  endif

  if has_key(plugs, 'telescope.nvim')
    nnoremap <leader>f <cmd>Telescope find_files<CR>
    nnoremap <leader>b <cmd>Telescope buffers<CR>
    nnoremap <leader>h <cmd>Telescope oldfiles<CR>
    nnoremap <leader>/ <cmd>Telescope live_grep<CR>
    nnoremap <leader>c <cmd>Telescope lsp_code_actions<CR>

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

let g:dashboard_default_executive = 'fzf'
let g:dashboard_custom_section = {
  \ '1': {
      \ 'description': ['  History                                        SPC h'],
      \ 'command': ':Telescope oldfiles' },
  \ '2': {
      \ 'description': ['  File file                                      SPC f'],
      \ 'command': ':Telescope find_files' },
  \ '3': {
      \ 'description': ['  Search text                                    SPC /'],
      \ 'command': ':Telescope live_grep' },
  \ '4': {
      \ 'description': ['  Empty buffer                                   :enew'],
      \ 'command': ':enew' },
  \ }
let g:dashboard_custom_header = [
  \ '                              ',
  \ ' g@@@@@@@@@@@@@@@@@@@@@@@@b_  ',
  \ '0@@@@@@@@@@@@@@@@@@@@@@@@@@@k  ',
  \ '0@@@@@@@@@@@@@^^#@@@@@@@@@@@@L  ',
  \ ' #@@@@@@@@@@"   J@@@@@@@@@@@@@  ',
  \ '               J@@@@@@@@@@@@@@b  ',
  \ '              d@@@@@##@@@@@@@@@L  ',
  \ '             d@@@@#   ^@@@@@@@@Q  ',
  \ '            d@@@@@@r    #@@@@@@@[  ',
  \ '           d@@@@@@@[     #@@@@@@@r  ',
  \ '          0@@@@@@@P       0@@@@@@%  ',
  \ '         0@@@@P            0@@@@@@L  ',
  \ '        0@@@@^              0@@@@@@  ',
  \ '       #@@@F                 0@@@@@b  ',
  \ '      1@@@^                   `@@@@@L  ',
  \ '                               ^@@@@@  ',
  \ '                                ^@@@@[  ',
  \ '                                  ##P  ',
  \ '',
  \ ]

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
