vim.o.timeoutlen = 500

vim.keymap.set("n", ";", ":")

vim.keymap.set("n", "<Up>", "<nop>")
vim.keymap.set("n", "<Down>", "<nop>")
vim.keymap.set("n", "<Left>", "<nop>")
vim.keymap.set("n", "<Right>", "<nop>")

vim.keymap.set({ "n", "t" }, "<C-n>", "<CMD>BufferLineCyclePrev<CR>")
vim.keymap.set({ "n", "t" }, "<C-m>", "<CMD>BufferLineCycleNext<CR>")

vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")

vim.keymap.set("x", "<leader>p", '"_dP')

require("legendary").setup({
  include_builtin = true,
  which_key = {
    auto_register = true,
  },
})
vim.keymap.set("n", "<C-p>", "<cmd>lua require('legendary').find()<CR>", { desc = "Open Legendary" })

local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    c = {
      name = "Code",
    },
    d = {
      name = "Debug",
      l = {
        name = "List",
      },
    },
    f = {
      name = "Files/Find",
    },
    g = {
      name = "Git",
      h = { name = "Hunk" },
    },
    m = {
      name = "Jumpwire",
    },
    n = { "<cmd>Neotree toggle<cr>", "NeoTree" },
    q = {
      name = "Quickfix",
      c = { "<cmd>cclose<CR>", "Close" },
    },
    S = {
      name = "Spectre",
    },
    t = {
      name = "Tests",
    },
    x = {
      name = "Errors",
    },
  },
})
