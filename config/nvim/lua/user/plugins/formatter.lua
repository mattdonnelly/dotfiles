local prettier = { "prettierd", "prettier" }
local eslint = { "eslint_d", "eslint" }

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile", "InsertEnter" },
  opts = {
    format = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      ruby = { "rubocop" },

      javascript = { prettier, eslint },
      typescript = { prettier, eslint },
      javascriptreact = { prettier, eslint },
      typescriptreact = { prettier, eslint },

      css = { prettier },
      scss = { prettier },
      html = { prettier },
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
