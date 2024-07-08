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

    local cwd = vim.loop.cwd()
    local maybe_config_path = vim.fn.fnamemodify(cwd .. "/eslint.config.js", ":p")
    local has_flat_config = vim.fn.filereadable(maybe_config_path) == 1

    if has_flat_config then
      local eslint_d = lint.linters.eslint_d
      eslint_d.env = {
        ["ESLINT_USE_FLAT_CONFIG"] = "true",
        ["CORE_D_TITLE"] = "eslint_d_flat",
        ["CORE_D_DOTFILE"] = ".eslint_d_flat",
        ["PWD"] = cwd,
        ["SHELL"] = os.getenv("SHELL"),
        ["TMPDIR"] = os.getenv("TMPDIR"),
        ["HOME"] = os.getenv("HOME"),
      }
    end
  end,
}
