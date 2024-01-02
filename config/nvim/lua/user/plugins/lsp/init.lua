return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    "hrsh7th/cmp-nvim-lsp",
    "b0o/SchemaStore.nvim",
    "pmizio/typescript-tools.nvim",
    "KostkaBrukowa/definition-or-references.nvim",

    "ray-x/lsp_signature.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "html",
        "cssls",
        "bashls",
        "lua_ls",
        "ember",
        "tsserver",
        "stylelint_lsp",
      },
    })

    require("user.plugins.lsp.diagnostics").setup()

    local on_attach = function(_, bufnr)
      require("user.plugins.lsp.keymaps").setup(bufnr)
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local default_config = {
      capabilities = capabilities,
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      },
    }

    lspconfig.html.setup(default_config)
    lspconfig.cssls.setup(default_config)
    lspconfig.bashls.setup(default_config)
    lspconfig.gopls.setup(default_config)
    lspconfig.eslint.setup(default_config)
    lspconfig.rubocop.setup(default_config)
    lspconfig.ruby_ls.setup(default_config)

    lspconfig.stylelint_lsp.setup({
      settings = {
        stylelintplus = {
          cssInJs = true,
        },
      },
    })

    lspconfig.jsonls.setup({
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    lspconfig.ember.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        on_attach(client, bufnr)
      end,
      root_dir = lspconfig.util.root_pattern("ember-cli-build.js"),
    })

    -- lspconfig.solargraph.setup({
    --   capabilities = capabilities,
    --   on_attach = function(client, bufnr)
    --     client.server_capabilities.documentFormattingProvider = false
    --     client.server_capabilities.documentRangeFormattingProvider = false
    --
    --     on_attach(client, bufnr)
    --   end,
    --   flags = {
    --     debounce_text_changes = 150,
    --   },
    --   init_options = {
    --     formatting = true,
    --   },
    --   settings = {
    --     solargraph = {
    --       diagnostics = false,
    --     },
    --   },
    -- })

    require("neodev").setup()
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    require("typescript-tools").setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        expose_as_code_action = "all",
        separate_diagnostic_server = false,
      },
    })

    require("lsp_signature").setup({ hint_enable = false, doc_lines = 0, transparency = 15 })
  end,
}
