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

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste (no register write)" })

vim.keymap.set("n", "<leader>qc", "<cmd>cclose<CR>", { desc = "Quickfix close" })

require("legendary").setup({
  include_builtin = true,
  which_key = {
    auto_register = true,
  },
})
vim.keymap.set("n", "<C-p>", "<cmd>lua require('legendary').find()<CR>", { desc = "Open Legendary" })

local wk = require("which-key")
wk.add({
  { "<leader>S", group = "Spectre" },
  { "<leader>c", group = "Code" },
  { "<leader>d", group = "Debug" },
  { "<leader>dl", group = "List" },
  { "<leader>f", group = "Files/Find" },
  { "<leader>g", group = "Git" },
  { "<leader>gh", group = "Hunk" },
  { "<leader>m", group = "Jumpwire" },
  { "<leader>q", group = "Quickfix" },
  { "<leader>t", group = "Tests" },
  { "<leader>x", group = "Errors" },
  { "g", group = "Go to" },
})
