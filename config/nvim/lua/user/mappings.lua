vim.o.timeoutlen = 500

vim.keymap.set("n", ";", ":")

vim.keymap.set("n", "<Up>", "<nop>")
vim.keymap.set("n", "<Down>", "<nop>")
vim.keymap.set("n", "<Left>", "<nop>")
vim.keymap.set("n", "<Right>", "<nop>")

vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")

local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    c = {
      name = "+code",
    },
    f = {
      name = "+find",
      f = { "<cmd>Telescope find_files<CR>", "Find files" },
      b = { "<cmd>Telescope buffers<CR>", "Buffers" },
      ["/"] = { "<cmd>Telescope live_grep<CR>", "Live search" },
      o = { [[<cmd>lua require('telescope.builtin').oldfiles({ only_cwd = true })<CR>]], "Recent files" },
      n = { "<cmd>DashboardNewFile<CR>", "New file" },
    },
    g = {
      name = "+git",
      l = {
        function()
          require("util").float_terminal({ "lazygit" })
        end,
        "LazyGit",
      },
      c = { "<Cmd>Telescope git_commits<CR>", "commits" },
      b = { "<Cmd>Telescope git_branches<CR>", "branches" },
      s = { "<Cmd>Telescope git_status<CR>", "status" },
      d = { "<cmd>DiffviewOpen<cr>", "DiffView" },
      h = { name = "+hunk" },
    },
    j = {
      { "<cmd>AnyJump<CR>", "AnyJump cursor" },
      { "<cmd>AnyJumpVisual<CR>", "AnyJump selected", mode = "v" },
    },
    m = {
      name = "+jumpwire",
    },
    n = { "<cmd>Neotree toggle<cr>", "NeoTree" },
    t = {
      name = "+tests",
      t = { ":TestFile<CR>", "Run full tests" },
      n = { ":TestNearest<CR>", "Run nearest test" },
      l = { ":TestLast<CR>", "Run last test" },
    },
    u = { ":UndotreeToggle<CR>", "Open Undotree" },
    x = {
      name = "+trouble",
      x = { "<cmd>Trouble<cr>", "Open trouble" },
      w = { "<cmd>Trouble workspace_diagnostics<cr>", "Trouble workspace" },
      d = { "<cmd>Trouble document_diagnostics<cr>", "Trouble document" },
      l = { "<cmd>Trouble loclist<cr>", "Trouble loclist" },
      q = { "<cmd>Trouble quickfix<cr>", "Trouble quickfix" },
    },
  },
  g = {
    name = "+goto",
    p = { "<cmd>:BufferLineCyclePrev<CR>", "Previous buffer" },
    n = { "<cmd>:BufferLineCycleNext<CR>", "Next buffer" },
  },
})
