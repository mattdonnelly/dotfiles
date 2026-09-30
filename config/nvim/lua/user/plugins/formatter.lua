local prettier = { "prettierd", "prettier", stop_after_first = true }

return {
  "stevearc/conform.nvim",
  enabled = require("user.features").formatting,
  event = { "BufReadPre", "BufNewFile", "InsertEnter" },
  opts = {
    format = {
      timeout_ms = 10000,
      async = false,
      quiet = false,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      ruby = { "rubocop" },
      java = { "spotless_gradle" },

      javascript = prettier,
      typescript = prettier,
      javascriptreact = prettier,
      typescriptreact = prettier,

      css = prettier,
      scss = prettier,
      html = prettier,
    },
    formatters = {
      rubocop = {
        command = "bundle",
        prepend_args = { "exec", "rubocop" },
      },
    },
    format_on_save = {
      lsp_fallback = true,
      timeout_ms = 3000,
    },
  },
}
