return {
  "mhartington/formatter.nvim",
  event = { "BufReadPre", "BufNewFile", "InsertEnter" },
  config = function()
    local util = require("formatter.util")

    local stylelua = require("formatter.filetypes.lua").stylua
    local prettierd = require("formatter.defaults").prettierd
    local eslint_d = require("formatter.defaults.eslint_d")
    local rubocop = require("formatter.filetypes.ruby").rubocop
    local ember_template_lint = function()
      return {
        exe = "ember-template-lint",
        args = {
          "--fix",
          util.escape_path(util.get_current_buffer_file_path()),
        },
      }
    end

    require("formatter").setup({
      logging = false,

      filetype = {
        lua = {
          stylelua,
        },
        json = {
          prettierd,
        },
        yaml = {
          prettierd,
        },
        typescript = {
          prettierd,
          eslint_d,
        },
        typescriptreact = {
          prettierd,
          eslint_d,
        },
        javascript = {
          prettierd,
          eslint_d,
        },
        javascriptreact = {
          prettierd,
          eslint_d,
        },
        css = {
          prettierd,
        },
        scss = {
          prettierd,
        },
        ruby = {
          rubocop,
        },
        ["html.handlebars"] = {
          ember_template_lint,
        },
        ["*"] = {
          require("formatter.filetypes.any").remove_trailing_whitespace,
        },
      },
    })
  end,
}
