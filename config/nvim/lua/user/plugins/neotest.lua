return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "olimorris/neotest-rspec",
    "haydenmeade/neotest-jest",
    "nvim-neotest/neotest-go",
  },
  keys = function()
    -- stylua: ignore
    return {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest tests" },
      { "<leader>tT", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Debug nearest tests" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run full test suite" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Debug nearest tests" },
      { "<leader>ts", function() require("neotest").run.stop() end, desc = "Stop nearest test" },
      { "<leader>ta", function() require("neotest").run.attach() end, desc = "Attach to nearest test" },
      { "<leader>to", function() require("neotest").output.open() end, desc = "Toggle test panel" },
      { "<leader>tp", function() require("neotest").output_panel.toggle() end, desc = "Toggle test panel" },
    }
  end,
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = vim.g.jest_command or "npm test",
        }),
        require("neotest-rspec")({
          rspecCommand = vim.g.rspec_command or "bundle exec rspec",
        }),
        require("neotest-go"),
      },
      discovery = {
        enabled = false,
      },
    })
  end,
}
