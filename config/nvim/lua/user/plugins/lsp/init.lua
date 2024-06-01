return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    "hrsh7th/cmp-nvim-lsp",
    "b0o/SchemaStore.nvim",
    "pmizio/typescript-tools.nvim",
    "luckasRanarison/tailwind-tools.nvim",

    "ray-x/lsp_signature.nvim",

    { "folke/lazydev.nvim", ft = "lua", opts = {} },
    { "Bilal2453/luvit-meta", lazy = true },
  },
  config = function()
    local on_attach = function(_, bufnr)
      require("user.plugins.lsp.keymaps").setup(bufnr)
    end

    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )

    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = {
        "html",
        "cssls",
        "bashls",
        "gopls",
        "eslint",
        "rubocop",
        "ruby_lsp",
        "lua_ls",
        "jsonls",
        "ember",
        "tsserver",
        "stylelint_lsp",
        "tailwindcss",
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
          })
        end,
        ["stylelint_lsp"] = function()
          require("lspconfig")["stylelint_lsp"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              stylelintplus = {
                cssInJs = true,
              },
            },
          })
        end,
        ["jsonls"] = function()
          require("lspconfig")["jsonls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
          })
        end,
        ["lua_ls"] = function()
          require("lspconfig")["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              client.server_capabilities.document_formatting = false
              client.server_capabilities.document_range_formatting = false
              on_attach(client, bufnr)
            end,
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                diagnostics = {
                  enable = true,
                },
                format = {
                  enable = false,
                },
                hint = {
                  enable = true,
                },
              },
            },
          })
        end,
        ["tsserver"] = function()
          require("typescript-tools").setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              expose_as_code_action = "all",
              separate_diagnostic_server = false,
            },
          })
        end,
      },
    })

    require("tailwind-tools").setup({
      document_color = {
        enabled = true,
        kind = "background",
      },
    })

    require("user.plugins.lsp.diagnostics").setup()

    require("lsp_signature").setup({ hint_enable = false, doc_lines = 0, transparency = 15 })
  end,
}
