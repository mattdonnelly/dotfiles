" ===========================================================================
" .vimrc of Matt Donnelly
" ============================================================================

set nocompatible
filetype plugin indent on

" ============================================================================
" Plugins {{{
" ============================================================================

if has("nvim")
  if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  call plug#begin('~/.local/share/nvim/plugged')
else
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  call plug#begin('~/.vim/plugged')
endif

" appearence plugins
Plug 'mattdonnelly/vim-noctu'
Plug 'mattdonnelly/vim-hybrid'
Plug 'mhinz/vim-startify'
Plug 'ayu-theme/ayu-vim'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'glepnir/spaceline.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'rakr/vim-one'

" integrations
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-emoji'
Plug 'ajh17/VimCompletesMe'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'sheerun/vim-polyglot'
Plug 'pechorin/any-jump.nvim'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-icons'
Plug 'kristijanhusak/defx-git'
Plug 'tpope/vim-endwise'

" js
Plug 'othree/yajs.vim', { 'for': 'javascript' } " enhanced js syntax highlighting

" python
Plug 'hdima/python-syntax', { 'for': 'python' }  " improved syntax highlighting
Plug 'tmhedberg/SimpylFold', { 'for': 'python' } " better folding

" ruby
Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }
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

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --smart-case --glob "!{.git,node_modules,gems}/*" 2> /dev/null'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
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
  colorscheme one
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
    nnoremap <leader>F :Files!<CR>
    nnoremap <leader>b :Buffer<CR>
    nnoremap <leader>h :History<CR>
    nnoremap <leader>/ :RG<CR>
    nnoremap <leader>? :RG!<CR>

    let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
    let $FZF_DEFAULT_OPTS='-i --multi --layout=reverse --margin=1,4'

    command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--info=inline']}), <bang>0)

    function! RipgrepFzf(query, fullscreen)
      let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command = printf(command_fmt, '{q}')
      let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction

    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

    function! CreateCenteredFloatingWindow()
      let width = min([&columns - 4, max([80, &columns - 20])])
      let height = min([&lines - 4, max([20, &lines - 10])])
      let top = ((&lines - height) / 2) - 1
      let left = (&columns - width) / 2
      let opts = { 'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal' }

      let top = "╭" . repeat("─", width - 2) . "╮"
      let mid = "│" . repeat(" ", width - 2) . "│"
      let bot = "╰" . repeat("─", width - 2) . "╯"
      let lines = [top] + repeat([mid], height - 2) + [bot]
      let s:buf = nvim_create_buf(v:false, v:true)
      call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
      call nvim_open_win(s:buf, v:true, opts)
      set winhl=Normal:Floating
      let opts.row += 1
      let opts.height -= 2
      let opts.col += 2
      let opts.width -= 4
      let opts.style = 'minimal'
      call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
      au BufWipeout <buffer> exe 'bw '.s:buf
    endfunction
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
      \ 'coc-snippets',
      \ 'coc-lists',
      \ ]

    inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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

    " Make <CR> auto-select the first completion item and notify coc.nvim to
    " format on enter, <cr> could be remapped by other vim plugin
    let g:endwise_no_mappings = 1
    inoremap <expr> <Plug>CustomCocCR pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    imap <CR> <Plug>CustomCocCR<Plug>DiscretionaryEnd

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

  if has_key(plugs, 'vim-rspec')
    map <Leader>t :call RunCurrentSpecFile()<CR>
    map <Leader>s :call RunNearestSpec()<CR>
    map <Leader>l :call RunLastSpec()<CR>
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

let g:python_host_prog = $HOME . '/.homebrew/bin/python2'
let g:python3_host_prog = $HOME . '/.homebrew/bin/python3'

let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'

let g:ale_linters = {
  \  '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'javascript': ['prettier', 'eslint'],
  \ 'ruby': ['rubocop'],
  \ }

let g:ale_fixers = {
  \ 'javascript': ['prettier', 'eslint'],
  \ 'ruby': ['rubocop'],
  \ }

let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_fix_on_save = 1

let g:any_jump_search_prefered_engine = 'rg'

let g:rspec_command = "term bundle exec rspec {spec}"

let g:startify_change_to_dir = 0

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
augroup END
" }}}

if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" ============================================================================
" vim: fdm=marker:sw=2:sts=2:et
