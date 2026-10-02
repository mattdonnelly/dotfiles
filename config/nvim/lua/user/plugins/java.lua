return {
  "nvim-java/nvim-java",
  enabled = require("user.features").lsp,
  ft = "java",
  dependencies = {
    -- provides the jdtls config and sets shared LSP defaults
    "neovim/nvim-lspconfig",
    -- nvim-java pins an old commit that uses the deprecated client.request
    { "JavaHello/spring-boot.nvim", commit = false },
  },
  config = function()
    require("java").setup()
    vim.lsp.enable("jdtls")
  end,
}
