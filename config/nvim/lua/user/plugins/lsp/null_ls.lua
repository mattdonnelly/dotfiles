local M = {}

function M.setup(on_attach)
  local mason_null_ls = require("mason-null-ls")
  local null_ls = require("null-ls")
  local null_ls_helpers = require("null-ls.helpers")
  local command_resolver = require("null-ls.helpers.command_resolver")

  null_ls.setup({
    debug = true,
    on_attach = on_attach,
    sources = {
      null_ls.builtins.formatting.rubocop,
      null_ls.builtins.diagnostics.rubocop,
      require("typescript.extensions.null-ls.code-actions"),
      {
        name = "ember-template-lint",
        method = null_ls.methods.FORMATTING,
        filetypes = { "html.handlebars" },
        generator = null_ls_helpers.formatter_factory({
          args = { "--fix", "$FILENAME" },
          command = "ember-template-lint",
        }),
      },
    },
  })

  mason_null_ls.setup({
    ensure_installed = {
      "stylua",
      "prettierd",
      "eslint_d",
    },
    automatic_installation = true,
    automatic_setup = true,
  })

  mason_null_ls.setup_handlers({
    function(source_name, methods)
      require("mason-null-ls.automatic_setup")(source_name, methods)
    end,
    prettierd = function()
      null_ls.register(null_ls.builtins.formatting.prettier.with({
        disabled_filetypes = { "html.handlebars", "json" },
        dynamic_command = command_resolver.from_node_modules(),
      }))
    end,
    eslint_d = function()
      local opts = {
        dynamic_command = command_resolver.from_node_modules(),
      }
      null_ls.register(null_ls.builtins.diagnostics.eslint_d.with(opts))
      null_ls.register(null_ls.builtins.code_actions.eslint_d.with(opts))
    end,
  })
end

return M
