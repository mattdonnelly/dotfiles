return {
  "mfussenegger/nvim-dap",
  enabled = require("user.features").debugging,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "mason-org/mason.nvim",
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
  },
  init = function()
    vim.g.dap_virtual_text = true
  end,
  keys = function()
    -- stylua: ignore
    return {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").step_back() end, desc = "Step Back" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run To Cursor" },
      { "<leader>dd", function() require("dap").disconnect() end, desc = "Disconnect" },
      { "<leader>dg", function() require("dap").session() end, desc = "Get Session" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle Repl" },
      { "<leader>ds", function() require("dap").continue() end, desc = "Start" },
      { "<leader>dq", function() require("dap").close() end, desc = "Quit" },
      { "<leader>du", function() require("dapui").toggle({ reset = true }) end, desc = "Toggle UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Evaluate expression", mode = { "n", "x" } },
    }
  end,
  config = function()
    -- Nerd Fonts v3 codepoints, escaped so the glyphs survive editing
    vim.fn.sign_define("DapBreakpoint", { text = "\u{f111}", texthl = "DiagnosticError" }) -- nf-fa-circle
    vim.fn.sign_define("DapBreakpointCondition", { text = "\u{f059}", texthl = "DiagnosticError" }) -- nf-fa-question_circle
    -- Shown while a breakpoint is unverified, e.g. before the debugger has loaded the file
    vim.fn.sign_define("DapBreakpointRejected", { text = "\u{f06a}", texthl = "DiagnosticWarn" }) -- nf-fa-exclamation_circle
    vim.fn.sign_define("DapLogPoint", { text = "\u{f075}", texthl = "DiagnosticInfo" }) -- nf-fa-comment
    vim.fn.sign_define("DapStopped", {
      text = "\u{f0054}", -- nf-md-arrow_right_bold
      texthl = "DiagnosticWarn",
      linehl = "CursorLine",
      numhl = "DiagnosticWarn",
    })

    require("nvim-dap-virtual-text").setup({})

    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    require("user.plugins.dap.javascript").setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
  end,
}
