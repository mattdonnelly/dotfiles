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
      name = "Find",
      n = { "<cmd>DashboardNewFile<CR>", "New file" },
      j = {
        { "<cmd>AnyJump<CR>", "AnyJump cursor" },
        { "<cmd>AnyJumpVisual<CR>", "AnyJump selected", mode = "v" },
      },
    },
    g = {
      name = "Git",
      h = { name = "Hunk" },
      J = { name = "Split/join toggle" },
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
      S = {
        [[<cmd>lua require("spectre").toggle()<CR>]],
        "Toggle Spectre",
      },
      w = {
        [[<cmd>lua require("spectre").open_visual({ select_word = true })<CR>]],
        "Search the current word",
      },
      v = {
        [[<cmd>lua require("spectre").open_visual()<CR>]],
        "Search the visual selection",
      },
      f = {
        [[<cmd>lua require("spectre").open_file_search()<CR>]],
        "Search in file",
      },
    },
    t = {
      name = "Tests",
      t = {
        [[<cmd>lua require("neotest").run.run()<CR>]],
        "Run nearest tests",
      },
      T = {
        [[<cmd>lua require("neotest").run.run({ strategy = "dap" })<CR>]],
        "Debug nearest tests",
      },
      f = {
        [[<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>]],
        "Run full test suite",
      },
      l = {
        [[<cmd>lua require("neotest").run.run_last()<CR>]],
        "Debug nearest tests",
      },
      s = {
        [[<cmd>lua require("neotest").run.stop()<CR>]],
        "Stop nearest test",
      },
      a = {
        [[<cmd>lua require("neotest").run.attach()<CR>]],
        "Attach to nearest test",
      },
      o = {
        [[<cmd>lua require("neotest").output.open()<CR>]],
        "Toggle test panel",
      },
      p = {
        [[<cmd>lua require("neotest").output_panel.toggle()<CR>]],
        "Toggle test panel",
      },
    },
    u = { ":UndotreeToggle<CR>", "Open Undotree" },
    x = {
      name = "Errors",
      x = { "<cmd>Trouble diagnostics toggle<cr>", "Trouble diagnostics" },
      X = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Trouble current buffer" },
      l = { "<cmd>Trouble loclist toggle<cr>", "Trouble loclist" },
      q = { "<cmd>Trouble quickfix toggle<cr>", "Trouble quickfix" },
      p = { "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "Trouble lsp references" },
    },
  },
})
