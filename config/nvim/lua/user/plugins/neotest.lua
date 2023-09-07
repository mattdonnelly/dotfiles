return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "olimorris/neotest-rspec",
    "haydenmeade/neotest-jest",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = vim.g.jest_command or "npm test",
        }),
        require("neotest-rspec")({
          rspecCommand = vim.g.rspec_command or "bundle exec rspec",
        }),
      },
      discovery = {
        enabled = false,
      },
    })
  end,
}
