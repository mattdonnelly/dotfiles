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

call plug#begin('~/.local/share/nvim/plugged')

" appearence plugins
Plug 'mattdonnelly/vim-noctu'
Plug 'mattdonnelly/vim-hybrid'
Plug 'mhinz/vim-startify'
Plug 'glepnir/galaxyline.nvim', { 'branch': 'main' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'rakr/vim-one'
Plug 'sainnhe/sonokai'
Plug 'psliwka/vim-smoothie'

" integrations
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim', { 'branch': 'main' }
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-emoji'
Plug 'ajh17/VimCompletesMe'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'pechorin/any-jump.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-icons'
Plug 'kristijanhusak/defx-git'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'vim-test/vim-test'
Plug 'JoosepAlviste/nvim-ts-context-commentstring', { 'branch': 'main' }
Plug 'windwp/nvim-ts-autotag', { 'branch': 'main' }

" js
Plug 'othree/yajs.vim', { 'for': 'javascript' } " enhanced js syntax highlighting

" python
Plug 'hdima/python-syntax', { 'for': 'python' }  " improved syntax highlighting
Plug 'tmhedberg/SimpylFold', { 'for': 'python' } " better folding

" ruby
Plug 'jgdavey/tslime.vim', { 'for': 'ruby' }

if filereadable(glob("~/.localplugins.vim"))
  source ~/.localplugins.vim
endif

call plug#end()

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
  let g:sonokai_style = 'atlantis'
  let g:sonokai_enable_italic = 1
  colorscheme sonokai
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

nnoremap <C-n> :BufferPrevious<CR>
nnoremap <C-m> :BufferNext<CR>

" Allows you to save files you opened without write permissions via sudo
cmap w!! w !sudo tee %

if exists('plugs')
  if has_key(plugs, 'telescope.nvim')
    nnoremap <leader>f :Telescope find_files<CR>
    nnoremap <leader>b :Telescope buffers<CR>
    nnoremap <leader>/ :Telescope live_grep<CR>
  endif

  if has_key(plugs, 'nvim-treesitter')
    lua require('plugins.treesitter')
  endif

  if has_key(plugs, 'defx.nvim')
    nnoremap <leader>n :Defx -toggle<CR>
    nnoremap <leader>N :Defx -toggle -search=`expand('%:p')` `getcwd()`<CR>

    call defx#custom#option('_', {
          \ 'columns': 'indent:git:icons:filename',
          \ 'winwidth': 35,
          \ 'split': 'vertical',
          \ 'direction': 'topleft',
          \ 'show_ignored_files': 0,
          \ 'buffer_name': 'defxplorer',
          \ })

    augroup user_plugin_defx
      autocmd!
      " Delete defx if it's the only buffer left in the window
      " autocmd WinEnter * if &filetype == 'defx' && winnr('$') == 1 | bd | endif

      " Move focus to the next window if current buffer is defx
      autocmd TabLeave * if &filetype == 'defx' | wincmd w | endif

      autocmd TabClosed * call s:defx_close_tab(expand('<afile>'))

      " Define defx window mappings
      autocmd FileType defx call s:defx_mappings()
    augroup END

    function! s:defx_close_tab(tabnr)
      " When a tab is closed, find and delete any associated defx buffers
      for l:nr in range(1, bufnr('$'))
        let l:defx = getbufvar(l:nr, 'defx')
        if empty(l:defx)
          continue
        endif
        let l:context = get(l:defx, 'context', {})
        if get(l:context, 'buffer_name', '') ==# 'tab' . a:tabnr
          silent! execute 'bdelete '.l:nr
          break
        endif
      endfor
    endfunction

    function! s:defx_toggle_tree() abort
      " Open current file, or toggle directory expand/collapse
      if defx#is_directory()
        return defx#do_action('open_or_close_tree')
      endif
      retur defx#do_action('drop')
    endfunction

    function! s:defx_mappings() abort
      " Defx window keyboard mappings
      setlocal signcolumn=no

      nnoremap <silent><buffer><expr> <backspace> defx#async_action('cd', ['..'])
      nnoremap <silent><buffer><expr> <CR>  defx#do_action('drop')
      nnoremap <silent><buffer><expr> <TAB> defx#do_action('open_or_close_tree')
      nnoremap <silent><buffer><expr> st    defx#do_action('multi', [['drop', 'tabnew'], 'quit'])
      nnoremap <silent><buffer><expr> %     defx#do_action('open', 'botright vsplit')
      nnoremap <silent><buffer><expr> -     defx#do_action('open', 'botright split')
      nnoremap <silent><buffer><expr> K     defx#do_action('new_directory')
      nnoremap <silent><buffer><expr> N     defx#do_action('new_file')
      nnoremap <silent><buffer><expr> M     defx#do_action('new_multiple_files')
      nnoremap <silent><buffer><expr> dd    defx#do_action('remove')
      nnoremap <silent><buffer><expr> r     defx#do_action('rename')
      nnoremap <silent><buffer><expr> x     defx#do_action('execute_system')
      nnoremap <silent><buffer><expr> .     defx#do_action('toggle_ignored_files')
      nnoremap <silent><buffer><expr> yy    defx#do_action('yank_path')
      nnoremap <silent><buffer><expr> q     defx#do_action('quit')
      nnoremap <silent><buffer><expr> <ESC> defx#do_action('quit')
      nnoremap <silent><buffer><expr><nowait> \  defx#do_action('cd', getcwd())
      nnoremap <silent><buffer><expr><nowait> &  defx#do_action('cd', getcwd())
      nnoremap <silent><buffer><expr><nowait> c  defx#do_action('copy')
      nnoremap <silent><buffer><expr><nowait> m  defx#do_action('move')
      nnoremap <silent><buffer><expr><nowait> p  defx#do_action('paste')
      nnoremap <silent><buffer><expr> '      defx#do_action('toggle_select') . 'j'
      nnoremap <silent><buffer><expr> *      defx#do_action('toggle_select_all')
    endfunction
  endif

  if has_key(plugs, 'barbar.nvim')
    let bufferline = {}
    let bufferline.clickable = v:true
  endif

  if has_key(plugs, 'undotree')
    nnoremap <leader>u :UndotreeToggle<CR>
  endif

  if has_key(plugs, 'vim-easy-align')
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)
  endif

  if has_key(plugs, 'coc.nvim')
    let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-json',
      \ 'coc-html',
      \ 'coc-vimlsp',
      \ 'coc-highlight',
      \ 'coc-emmet',
      \ 'coc-pairs',
      \ 'coc-lists',
      \ ]

    inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    if has('nvim')
      inoremap <silent><expr> <c-space> coc#refresh()
    else
      inoremap <silent><expr> <c-@> coc#refresh()
    endif

    inoremap <silent><expr> <c-space> coc#refresh()

    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    nnoremap <silent> K :call <SID>show_documentation()<CR>
    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    set signcolumn=auto:2
  endif

  if has_key(plugs, 'vim-test')
    map <Leader>t :TestFile<CR>
    map <Leader>s :TestNearest<CR>
    map <Leader>l :TestLast<CR>
    let test#strategy = {
      \ 'nearest': 'neovim',
      \ 'file':    'neovim',
      \ 'suite':   'basic',
      \}
  endif

  if has_key(plugs, 'nvim-ts-autotag')
    lua require('nvim-ts-autotag').setup()
  endif

  if has_key(plugs, 'gitsigns.nvim')
    lua require('gitsigns').setup()
  endif

  if has_key(plugs, 'galaxyline.nvim')
    function! ConfigStatusLine()
      lua require('plugins.galaxyline')
    endfunction

    augroup status_line_init
      autocmd!
      autocmd VimEnter * call ConfigStatusLine()
    augroup END
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

let g:ale_sign_error = '✖'
let g:ale_sign_warning = ''
let g:ale_disable_lsp = 1

let g:ale_linters = {
  \  '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'javascript': ['prettier', 'eslint'],
  \ 'ruby': ['rubocop'],
  \ }

let g:ale_fixers = {
  \ 'javascript': ['prettier', 'eslint'],
  \ 'ruby': ['rubocop'],
  \ }

let g:ale_ruby_rubocop_executable = 'rubocop'
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_delay = 0

au VimEnter,BufEnter,ColorScheme *
  \ exec "hi! ALEInfoLine
    \ guifg=".(&background=='light'?'#808000':'#ffff00')."
    \ guibg=".(&background=='light'?'#ffff00':'#555500') |
  \ exec "hi! ALEWarningLine
    \ guifg=".(&background=='light'?'#808000':'#ffff00')."
    \ guibg=".(&background=='light'?'#ffff00':'#555500') |
  \ exec "hi! ALEErrorLine
    \ guifg=".(&background=='light'?'#ff0000':'#ff0000')."
    \ guibg=".(&background=='light'?'#ffcccc':'#550000')

let g:any_jump_search_prefered_engine = 'rg'
let g:any_jump_references_enabled = 0

let g:rspec_command = "term bundle exec rspec {spec}"

let g:startify_change_to_dir = 0

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

  autocmd FileType python highlight Excess ctermbg=Red
  autocmd FileType python match Excess /\%120v.*/
  autocmd FileType python,actionscript setlocal
    \ expandtab
    \ tabstop=4
    \ softtabstop=4
    \ shiftwidth=4

  " allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END
" }}}

if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" ============================================================================
" vim: fdm=marker:sw=2:sts=2:et
