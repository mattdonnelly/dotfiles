local features = require("user.features")

return {
  { "mason-org/mason-lspconfig.nvim", enabled = features.lsp },

  "nvim-lua/plenary.nvim",

  { "numToStr/Navigator.nvim", event = "VeryLazy",   config = true },

  "MunifTanjim/nui.nvim",
  {
    "folke/which-key.nvim",
    dependencies = {
      "echasnovski/mini.icons",
    },
    opts = {
      plugins = {
        registers = false,
      },
    },
  },
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle", "UndotreeShow", "UndotreeHide", "UndotreeFocus" },
    keys = {
      { "<leader>u", ":UndotreeToggle<CR>", desc = "Open Undotree" },
    },
  },
  {
    "tzachar/highlight-undo.nvim",
    config = true,
    keys = {
      { "u" },
      { "<C-r>" },
    },
  },
}
