return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
    {
      "mxsdev/nvim-dap-vscode-js",
      dependencies = {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      },
    },
  },
  lazy = "VeryLazy",
  init = function()
    vim.g.dap_virtual_text = true
  end,
  keys = function()
    -- stylua: ignore
    return {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").step_back() end, "Step Back" },
      { "<leader>dc", function() require("dap").continue() end, "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, "Run To Cursor" },
      { "<leader>dd", function() require("dap").disconnect() end, "Disconnect" },
      { "<leader>dg", function() require("dap").session() end, "Get Session" },
      { "<leader>di", function() require("dap").step_into() end, "Step Into" },
      { "<leader>do", function() require("dap").step_over() end, "Step Over" },
      { "<leader>dO", function() require("dap").step_out() end, "Step Out" },
      { "<leader>dp", function() require("dap").pause() end, "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, "Toggle Repl" },
      { "<leader>ds", function() require("dap").continue() end, "Start" },
      { "<leader>dq", function() require("dap").close() end, "Quit" },
      { "<leader>du", function() require("dapui").toggle({ reset = true }) end, "Toggle UI" },
      { "<leader>de", function() require("dapui").eval() end, "DAP evaluate expression", mode = { "n", "x" } },
    }
  end,
  config = function()
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Error" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "לּ", texthl = "Error" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "Error" })
    vim.fn.sign_define("DapLogPoint", { text = "", texthl = "Directory" })
    vim.fn.sign_define("DapStopped", {
      text = "ﰲ",
      texthl = "TSConstant",
      linehl = "CursorLine",
      numhl = "LspDiagnosticsSignInformation",
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
