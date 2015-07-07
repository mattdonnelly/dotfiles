set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" appearence plugins
Plugin 'scrooloose/nerdtree'      " file tree
Plugin 'mhinz/vim-startify'       " helpful start page
Plugin 'sjl/badwolf'              " theme
Plugin 'bling/vim-airline'        " status line theme

" integrations
Plugin 'scrooloose/syntastic.git'       " syntax checking
Plugin 'ctrlpvim/ctrlp.vim'             " fuzzy searching
Plugin 'jiangmiao/auto-pairs'           " pair quotes, brackets, etc.
Plugin 'Valloric/YouCompleteMe'         " auto completion
Plugin 'Lokaltog/vim-easymotion'        " movement without numbers
Plugin 'airblade/vim-gitgutter'         " git status
Plugin 'tpope/vim-fugitive'             " git integration
Plugin 'christoomey/vim-tmux-navigator' " tmux + vim pane navigation
Plugin 'tpope/vim-surround'             " easier surronding characters

call vundle#end()

filetype plugin indent on

" switch syntax highlighting on, when the terminal has colors
" also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    syntax on
endif

set encoding=utf-8                 " allow rich text
colorscheme badwolf                " set syntax colouring theme

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
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

nnoremap \ :Ag<SPACE>

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
set number                 " line numbers
set numberwidth=4          " gutter width
set cursorline             " show current line
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

nnoremap ; :
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

nmap <silent> <C-n> :NERDTreeFocus<cr>

" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|bower_components|\.git|\.hg|\.svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled=1
let g:airline#syntastic#enabled=1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'

let g:syntastic_python_checker = 'flake8'

let g:syntastic_cpp_compiler = 'clang++'
set showcmd
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -Wall'
