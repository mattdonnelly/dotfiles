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
        version = "1.74.0",
        build = "npm i --legacy-peer-deps && npm run compile",
      },
    },
  },
  lazy = false,
  init = function()
    vim.g.dap_virtual_text = true
    require("user.plugins.dap.keymaps").setup()
  end,
  config = function()
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Error" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "לּ", texthl = "Error" })
    vim.fn.sign_define("DapLogPoint", { text = "", texthl = "Directory" })
    vim.fn.sign_define("DapStopped", { text = "ﰲ", texthl = "TSConstant" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "Error" })

    require("nvim-dap-virtual-text").setup()

    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    require("user.plugins.dap.javascript").setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
}
