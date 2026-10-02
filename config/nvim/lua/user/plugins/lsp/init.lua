return {
  "neovim/nvim-lspconfig",
  enabled = require("user.features").lsp,
  event = "BufReadPre",
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",

    "saghen/blink.cmp",
    "b0o/SchemaStore.nvim",
    "pmizio/typescript-tools.nvim",

    { "folke/lazydev.nvim",   ft = "lua", opts = {} },
    { "Bilal2453/luvit-meta", lazy = true },
  },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.lsp.config("eslint", {
      settings = {
        workingDirectories = { "./" },
        experimental = {
          useFlatConfig = false,
        },
      },
    })

    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })

    vim.lsp.config("jsonls", {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    vim.lsp.config("stylelint_lsp", {
      settings = {
        stylelintplus = {
          cssInJs = true,
        },
      },
    })

    local ensure_installed = {
      "html",
      "cssls",
      "bashls",
      "eslint",
      "lua_ls",
      "jsonls",
      "ts_ls",
      "stylelint_lsp",
    }

    local copilot = require("user.features").copilot
    if copilot then
      table.insert(ensure_installed, "copilot")
    end

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = ensure_installed,
      automatic_enable = {
        -- typescript-tools.nvim runs tsserver itself
        exclude = { "ts_ls" },
      },
    })

    require("typescript-tools").setup({
      capabilities = capabilities,
      settings = {
        expose_as_code_action = "all",
        separate_diagnostic_server = false,
      },
    })

    require("user.plugins.lsp.diagnostics").setup()

    require("user.plugins.lsp.keymaps").setup()

    if copilot then
      -- Native inline completion; sign in once with :LspCopilotSignIn
      vim.lsp.inline_completion.enable()
    end
  end,
}
