return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "williamboman/mason.nvim",
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
    {
      "mxsdev/nvim-dap-vscode-js",
      dependencies = {
        "microsoft/vscode-js-debug",
        opt = true,
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      },
    },
  },
  lazy = "VeryLazy",
  init = function()
    vim.g.dap_virtual_text = true
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

    require("nvim-dap-virtual-text").setup()

    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    require("user.plugins.dap.javascript").setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    -- dap.listeners.before.event_terminated["dapui_config"] = function()
    --   dapui.close()
    -- end
    -- dap.listeners.before.event_exited["dapui_config"] = function()
    --   dapui.close()
    -- end
  end,
}
