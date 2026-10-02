vim.opt.encoding = "utf-8"

vim.opt.compatible = false
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"

if vim.env.SSH_TTY then
  local osc52 = require("vim.ui.clipboard.osc52")

  local function paste()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end

  vim.g.clipboard = {
    name = "OSC 52",
    copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
    paste = { ["+"] = paste, ["*"] = paste },
  }
end

vim.opt.swapfile = false
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.showtabline = 2

-- open new split panes to right and bottom, which feels more natural
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.backspace = "start,eol,indent"
vim.opt.list = true
vim.opt.listchars:append({ tab = "‣ ", trail = "·", nbsp = "·", eol = "↲" })

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
vim.opt.autoread = true
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.grepprg = "rg --vimgrep"

vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.ruler = true
vim.opt.laststatus = 2
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.mouse = "a"

vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Avoid shelling out to `brew --prefix`, which is slow on startup
local brew = vim.fn.exepath("brew")
if brew ~= "" then
  local brew_prefix = vim.env.HOMEBREW_PREFIX or vim.fn.fnamemodify(brew, ":h:h")
  vim.g.python3_host_prog = brew_prefix .. "/bin/python3"
end

vim.g.mapleader = " "

vim.filetype.add({
  extension = {
    vpy = "python",
  },
})
