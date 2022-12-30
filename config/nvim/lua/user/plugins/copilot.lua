return {
  "zbirenbaum/copilot-cmp",
  dependencies = {
    "zbirenbaum/copilot.lua",
  },
  cond = vim.g.copilot_enabled,
  event = "VeryLazy",
  config = function()
    vim.schedule(function()
      require("copilot").setup({
        filetypes = {
          ["dap-repl"] = false,
        },
      })
      require("copilot_cmp").setup({
        method = "getCompletionsCycling",
        formatters = {
          label = require("copilot_cmp.format").format_label_text,
          insert_text = require("copilot_cmp.format").format_insert_text,
          preview = require("copilot_cmp.format").deindent,
        },
      })
    end)
  end,
}
