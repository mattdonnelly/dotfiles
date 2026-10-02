return {
  "nvim-java/nvim-java",
  enabled = require("user.features").lsp,
  ft = "java",
  dependencies = {
    "neovim/nvim-lspconfig",
    -- nvim-java pins an old commit that uses the deprecated client.request.
    -- Newer commits (9880be4+) block the UI with vim.wait() while jdtls imports.
    { "JavaHello/spring-boot.nvim", commit = "eea95b752bceb6ca410b3e2d87a1a02d08bd61a6" },
  },
  config = function()
    require("java").setup()

    vim.lsp.config("jdtls", {
      settings = {
        java = {
          configuration = { updateBuildConfiguration = "automatic" },
        },
      },
    })
    vim.lsp.enable("jdtls")

    vim.api.nvim_create_user_command("JavaUpdateProjectConfig", function()
      local bufnr = vim.api.nvim_get_current_buf()
      local client = vim.lsp.get_clients({ name = "jdtls", bufnr = bufnr })[1]
      if not client then
        vim.notify("jdtls is not attached to this buffer", vim.log.levels.WARN)
        return
      end
      client:notify("java/projectConfigurationUpdate", { uri = vim.uri_from_bufnr(bufnr) })
      vim.notify("Reloading Java project configuration")
    end, { desc = "Re-import the Gradle/Maven project for the current file" })
  end,
}
