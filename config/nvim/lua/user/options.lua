vim.opt.encoding = 'utf-8'

vim.opt.compatible = false
vim.opt.showmode = false
vim.opt.clipboard = 'unnamed'

vim.opt.undodir = vim.fn.stdpath('cache') .. '/undo'
vim.opt.undofile = true

vim.g['&t_ZM'] = '\\e[4m' -- Italics in tmux

vim.opt.termguicolors = true

vim.opt.showtabline = 2

-- open new split panes to right and bottom, which feels more natural
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.backspace = 'start,eol,indent'
vim.opt.list = true
vim.opt.listchars:append({ tab = '‣ ', trail = '·', nbsp = '·', eol = '↲' })

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

vim.opt.whichwrap:append '<,>,[,],h,l'
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

vim.g.mapleader = ' '
