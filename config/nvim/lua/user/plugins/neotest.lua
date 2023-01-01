return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    { "haydenmeade/neotest-jest", dev = true },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = vim.g.jest_command or "npm test --",
        }),
      },
      discovery = {
        enabled = false,
      },
    })
  end,
}
