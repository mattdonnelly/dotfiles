return {
  "neovim/nvim-lspconfig",
  enabled = require("user.features").lsp,
  event = "BufReadPre",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    "hrsh7th/cmp-nvim-lsp",
    "b0o/SchemaStore.nvim",
    "pmizio/typescript-tools.nvim",
    "nvim-java/nvim-java",
    -- nvim-java pins an old commit that uses the deprecated client.request
    { "JavaHello/spring-boot.nvim", commit = false },

    { "folke/lazydev.nvim",   ft = "lua", opts = {} },
    { "Bilal2453/luvit-meta", lazy = true },
  },
  config = function()
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )

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

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "html",
        "cssls",
        "bashls",
        "eslint",
        "lua_ls",
        "jsonls",
        "ts_ls",
        "stylelint_lsp",
      },
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

    require('java').setup()
    vim.lsp.enable('jdtls')
  end,
}
