-- .vimrc of Matt Donnelly

vim.opt.encoding = 'utf-8'

vim.opt.compatible = false
vim.opt.showmode = false
vim.opt.clipboard = "unnamed"

vim.opt.undodir = vim.fn.expand('~/.vim-undo/')
vim.opt.undofile = true

vim.cmd([[let &t_ZM = "\e[4m"]]) -- Italics in tmux

vim.opt.termguicolors = true

vim.opt.showtabline = 2

-- open new split panes to right and bottom, which feels more natural
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.backspace = 'start,eol,indent'
vim.opt.list = true
vim.opt.listchars:append({ tab = '‣ ', trail = '·', nbsp = '·', eol = '¬' })

vim.opt.updatetime = 300

-- When the page starts to scroll, keep the cursor 8 lines from the top
-- and 8 lines from the bottom and 15 lines on the left
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 8

vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.autochdir = false 
vim.opt.swapfile = true
vim.opt.autoread = true
vim.opt.number = true
vim.opt.numberwidth = 4

vim.opt.whichwrap:append "<,>,[,],h,l"
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.ruler = true
vim.opt.laststatus = 2
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.mouse = 'a'

vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 99

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

local brew_prefix = vim.fn.system('echo -n $(brew --prefix)')
vim.g.python_host_prog = brew_prefix .. '/bin/python'
vim.g.python3_host_prog = brew_prefix .. '/bin/python3'

vim.g.any_jump_search_prefered_engine = 'rg'
vim.g.any_jump_references_enabled = 0

vim.cmd([[
" ============================================================================
" Plugins {{{
" ============================================================================

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

source ~/.config/nvim/plugins.lua
" }}}
]])

vim.cmd("colorscheme tokyonight-night")

-- Key bindings

vim.g.mapleader = ' '

vim.keymap.set('n', ';', ':')

vim.keymap.set('n', '<Up>', '<nop>')
vim.keymap.set('n', '<Down>', '<nop>')
vim.keymap.set('n', '<Left>', '<nop>')
vim.keymap.set('n', '<Right>', '<nop>')

vim.keymap.set('n', 'gn', ':BufferNext<cr>')
vim.keymap.set('n', 'gp', ':BufferPrevious<cr>')

vim.cmd([[
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
    let bufferline.exclude_ft = ['qf', 'nerdtree']
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

  if has_key(plugs, 'nvim-scrollbar')
    lua require("scrollbar").setup()
  end
endif
]])

local vimrc_augroup = vim.api.nvim_create_augroup('vimrcEx', {})

vim.api.nvim_create_autocmd('BufReadPost *', {
  group = vimrc_augroup,
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = group_name,
  command = [[ 
    if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      exe "normal g`\"" |
    endif
  ]],
})

vim.api.nvim_create_autocmd("FileType", {
  group = group_name,
  pattern = { "css", "scss", "sass" },
  command = "setlocal iskeyword+=-",
})

vim.cmd([[
if filereadable(glob("~/.config/nvim/init.local.vim"))
  source ~/.config/nvim/init.local.vim
endif
]])
