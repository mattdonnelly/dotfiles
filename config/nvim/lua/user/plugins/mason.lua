local servers = {
  "ember-language-server",
  "html-lsp",
  "css-lsp",
  "bash-language-server",
  "lua-language-server",
  "vim-language-server",
  "typescript-language-server",
}

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_installation = true,
    })
  end,
}
