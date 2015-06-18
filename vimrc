set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" appearence plugins
Plugin 'scrooloose/nerdtree'       " file tree
Plugin 'mhinz/vim-startify'        " helpful start page
Plugin 'sjl/badwolf'               " theme
Plugin 'bling/vim-airline'         " status line theme
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'
let g:airline#extensions#branch#enabled=1
let g:airline#syntastic#enabled=1

" integrations
Plugin 'scrooloose/syntastic.git' " syntax checking
Plugin 'ctrlpvim/ctrlp.vim'       " fuzzy searching
Plugin 'jiangmiao/auto-pairs'     " pair quotes, brackets, etc.
Plugin 'Valloric/YouCompleteMe'   " auto completion
Plugin 'Lokaltog/vim-easymotion'  " movement without numbers
Plugin 'airblade/vim-gitgutter'   " git status
Plugin 'tpope/vim-fugitive'

call vundle#end()

filetype plugin indent on

" switch syntax highlighting on, when the terminal has colors
" also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    syntax on
endif

set encoding=utf-8                 " allow rich text
colorscheme badwolf                " set syntax colouring theme
highlight LineNr guibg=grey

set viminfo='100,n$HOME/.vim/files/info' " set viminfo

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

set backspace=2
set list listchars=tab:→·,trail:·,nbsp:· " display extra whitespace

" When the page starts to scroll, keep the cursor 8 lines from the top
" and 8 lines from the bottom and 15 lines on the left
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

set number                 " line numbers
set numberwidth=4          " gutter width
set cursorline             " show current line
set whichwrap+=<,>,h,l,[,] " cursor line wrapping
set hlsearch               " search highlighting
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
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_python_checker = 'pep8'

let g:syntastic_stl_format = '[%E{%e Errors}%B{, }%W{%w Warnings}]'
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -Wall'
