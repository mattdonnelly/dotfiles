return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile", "InsertEnter" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }
  end,
}
