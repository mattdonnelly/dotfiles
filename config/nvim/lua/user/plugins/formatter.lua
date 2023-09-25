local prettier = { "prettierd", "prettier" }
local eslint = { "eslint_d", "eslint" }

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile", "InsertEnter" },
  opts = {
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
    format_on_save = {
      lsp_fallback = true,
      timeout_ms = 500,
    },
  },
  -- config = function()
  --   local util = require("formatter.util")
  --
  --   local stylelua = require("formatter.filetypes.lua").stylua
  --   local prettierd = require("formatter.defaults").prettierd
  --   local eslint_d = require("formatter.defaults.eslint_d")
  --   local rubocop = require("formatter.filetypes.ruby").rubocop
  --   local ember_template_lint = function()
  --     return {
  --       exe = "ember-template-lint",
  --       args = {
  --         "--fix",
  --         util.escape_path(util.get_current_buffer_file_path()),
  --       },
  --     }
  --   end
  --
  --   require("formatter").setup({
  --     logging = false,
  --
  --     filetype = {
  --       lua = {
  --         stylelua,
  --       },
  --       json = {
  --         prettierd,
  --       },
  --       yaml = {
  --         prettierd,
  --       },
  --       typescript = {
  --         prettierd,
  --         eslint_d,
  --       },
  --       typescriptreact = {
  --         prettierd,
  --         eslint_d,
  --       },
  --       javascript = {
  --         prettierd,
  --         eslint_d,
  --       },
  --       javascriptreact = {
  --         prettierd,
  --         eslint_d,
  --       },
  --       css = {
  --         prettierd,
  --       },
  --       scss = {
  --         prettierd,
  --       },
  --       ruby = {
  --         rubocop,
  --       },
  --       ["html.handlebars"] = {
  --         ember_template_lint,
  --       },
  --       ["*"] = {
  --         require("formatter.filetypes.any").remove_trailing_whitespace,
  --       },
  --     },
  --   })
}
