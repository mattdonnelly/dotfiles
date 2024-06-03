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
      { "<leader>b", function() require("dap").toggle_breakpoint() end, "Toggle Breakpoint" },
      { "<leader>B", function() require("dap").step_back() end, "Step Back" },
      { "<leader>c", function() require("dap").continue() end, "Continue" },
      { "<leader>C", function() require("dap").run_to_cursor() end, "Run To Cursor" },
      { "<leader>d", function() require("dap").disconnect() end, "Disconnect" },
      { "<leader>g", function() require("dap").session() end, "Get Session" },
      { "<leader>i", function() require("dap").step_into() end, "Step Into" },
      { "<leader>o", function() require("dap").step_over() end, "Step Over" },
      { "<leader>O", function() require("dap").step_out() end, "Step Out" },
      { "<leader>p", function() require("dap").pause() end, "Pause" },
      { "<leader>r", function() require("dap").repl.toggle() end, "Toggle Repl" },
      { "<leader>s", function() require("dap").continue() end, "Start" },
      { "<leader>q", function() require("dap").close() end, "Quit" },
      { "<leader>u", function() require("dapui").toggle({ reset = true }) end, "Toggle UI" },
      { "<leader>e", function() require("dapui").eval() end, "DAP evaluate expression", mode = { "n", "x" } },
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
