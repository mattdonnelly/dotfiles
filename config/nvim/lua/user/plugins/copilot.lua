return {
  "zbirenbaum/copilot-cmp",
  dependencies = {
    "zbirenbaum/copilot.lua",
  },
  event = "VeryLazy",
  config = function()
    vim.schedule(function()
      require("copilot").setup()
      require("copilot_cmp").setup()
    end)
  end,
}
