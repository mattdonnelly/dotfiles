return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "haydenmeade/neotest-jest",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = "yarn run test:unit",
          jestConfigFile = "jest.config.js",
          cwd = function(_)
            return vim.fn.getcwd()
          end,
        }),
      },
      output = {
        enable = true,
        open_on_run = true,
      },
    })
  end,
}
