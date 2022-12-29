local M = {
  "VonHeikemen/lsp-zero.nvim",
  event = "BufReadPre",
  dependencies = {
    "neovim/nvim-lspconfig",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "jose-elias-alvarez/null-ls.nvim",
    "jayp0521/mason-null-ls.nvim",
    "jose-elias-alvarez/typescript.nvim",

    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-path",
    "onsails/lspkind.nvim",
    "folke/neodev.nvim",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
}

function M.config()
  local lsp = require("lsp-zero")
  lsp.preset("recommended")

  require("user.plugins.lsp.diagnostics").setup(lsp)
  require("user.plugins.lsp.cmp").setup(lsp)

  lsp.ensure_installed({
    "html",
    "cssls",
    "bashls",
    "vimls",
    "sumneko_lua",
    "solargraph",
    "ember",
    "tsserver",
  })

  lsp.on_attach(function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
    end
  end)

  local default_config = {
    flags = {
      debounce_text_changes = 150,
    },
  }

  lsp.setup_servers({
    "html",
    "cssls",
    "bashls",
    "vimls",
  }, default_config)

  require("neodev").setup({})
  lsp.configure("sumneko_lua", {
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

  lsp.configure("solargraph", {
    flags = {
      debounce_text_changes = 150,
    },
    init_options = {
      formatting = true,
    },
    settings = {
      solargraph = {
        formatting = false,
      },
    },
  })

  lsp.configure("ember", {
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  })

  local tsserver_opts = lsp.build_options("tsserver", {
    on_attach = function(_, bufnr)
      local opts = { noremap = true, silent = true }
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspRenameFile<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "go", ":TSLspImportAll<CR>", opts)
    end,
  })

  lsp.setup()

  require("typescript").setup({
    go_to_source_definition = {
      fallback = true,
    },
    flags = {
      debounce_text_changes = 150,
    },
    server = tsserver_opts,
  })

  require("user.plugins.lsp.null_ls").setup(lsp)
end

return M
