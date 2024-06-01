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
      b = { [[<cmd>lua require("dap").toggle_breakpoint()<cr>]], "Toggle Breakpoint" },
      B = { [[<cmd>lua require("dap").step_back()<cr>]], "Step Back" },
      c = { [[<cmd>lua require("dap").continue()<cr>]], "Continue" },
      C = { [[<cmd>lua require("dap").run_to_cursor()<cr>]], "Run To Cursor" },
      d = { [[<cmd>lua require("dap").disconnect()<cr>]], "Disconnect" },
      g = { [[<cmd>lua require("dap").session()<cr>]], "Get Session" },
      i = { [[<cmd>lua require("dap").step_into()<cr>]], "Step Into" },
      o = { [[<cmd>lua require("dap").step_over()<cr>]], "Step Over" },
      O = { [[<cmd>lua require("dap").step_out()<cr>]], "Step Out" },
      p = { [[<cmd>lua require("dap").pause()<cr>]], "Pause" },
      r = { [[<cmd>lua require("dap").repl.toggle()<cr>]], "Toggle Repl" },
      s = { [[<cmd>lua require("dap").continue()<cr>]], "Start" },
      q = { [[<cmd>lua require("dap").close()<cr>]], "Quit" },
      u = { [[<cmd>lua require("dapui").toggle({reset = true})<cr>]], "Toggle UI" },
      e = { [[<cmd>lua require("dapui").eval<CR>]], "DAP evaluate expression", mode = { "n", "x" } },
      l = {
        name = "List",
        b = { [[<cmd>lua require("telescope").extensions.dap.list_breakpoints{}<CR>]], "List breakpoints" },
        v = { [[<cmd>lua require("telescope").extensions.dap.variables{}<CR>]], "List variables" },
        f = { [[<cmd>lua require("telescope").extensions.dap.frames{}<CR>]], "List frames" },
      },
    },
    f = {
      name = "Find",
      f = { "<cmd>Telescope find_files<CR>", "Find files" },
      b = { "<cmd>Telescope buffers<CR>", "Buffers" },
      ["/"] = { "<cmd>Telescope live_grep<CR>", "Live search" },
      o = { [[<cmd>lua require('telescope.builtin').oldfiles({ only_cwd = true })<CR>]], "Recent files" },
      n = { "<cmd>DashboardNewFile<CR>", "New file" },
      j = {
        { "<cmd>AnyJump<CR>", "AnyJump cursor" },
        { "<cmd>AnyJumpVisual<CR>", "AnyJump selected", mode = "v" },
      },
    },
    g = {
      name = "Git",
      l = { "<cmd>LazyGit<CR>", "LazyGit" },
      c = { "<cmd>Telescope git_commits<CR>", "commits" },
      b = { "<cmd>Telescope git_branches<CR>", "branches" },
      s = { "<cmd>Telescope git_status<CR>", "status" },
      d = { "<cmd>DiffviewOpen<cr>", "DiffView" },
      h = { name = "Hunk" },
      j = { name = "Split/join toggle" },
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
      p = { "<cmd>Trouble lsp toggle<cr>", "Trouble lsp references" },
    },
  },
  g = {
    name = "Goto",
    p = { "<cmd>:BufferLineCyclePrev<CR>", "Previous buffer" },
    n = { "<cmd>:BufferLineCycleNext<CR>", "Next buffer" },
  },
})
