return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    "hrsh7th/cmp-nvim-lsp",
    "b0o/SchemaStore.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "jayp0521/mason-null-ls.nvim",
    "jose-elias-alvarez/typescript.nvim",

    "ray-x/lsp_signature.nvim",
    { "lukas-reineke/lsp-format.nvim", config = true },
  },
  config = function()
    local lspconfig = require("lspconfig")

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "html",
        "cssls",
        "bashls",
        "sumneko_lua",
        "ember",
        "tsserver",
        "solargraph",
      },
    })

    require("user.plugins.lsp.diagnostics").setup()

    local on_attach = function(client, bufnr)
      require("user.plugins.lsp.keymaps").setup(bufnr)

      if client.server_capabilities.documentFormattingProvider then
        require("lsp-format").on_attach(client)
      end

      if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
      end
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

    lspconfig.solargraph.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        on_attach(client, bufnr)
      end,
      flags = {
        debounce_text_changes = 150,
      },
      init_options = {
        formatting = true,
      },
      settings = {
        solargraph = {
          diagnostics = false,
        },
      },
    })

    require("neodev").setup()
    lspconfig.sumneko_lua.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    require("typescript").setup({
      capabilities = capabilities,
      go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
      },
      server = {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false

          local opts = { noremap = true, silent = true }
          vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspRenameFile<CR>", opts)
          vim.api.nvim_buf_set_keymap(bufnr, "n", "go", ":TSLspImportAll<CR>", opts)

          on_attach(client, bufnr)
        end,
        flags = {
          debounce_text_changes = 150,
        },
      },
    })

    require("user.plugins.lsp.null_ls").setup(on_attach)

    require("lsp_signature").setup({ hint_enable = false, doc_lines = 0, transparency = 15 })
  end,
}
