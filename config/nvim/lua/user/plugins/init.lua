return {
  "nathom/filetype.nvim",

  "RishabhRD/popfix",
  "RishabhRD/nvim-lsputils",
  "williamboman/mason-lspconfig.nvim",

  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",

  { "psliwka/vim-smoothie", event = "BufWinEnter" },
  { "j-hui/fidget.nvim", event = "VeryLazy", config = true },
  { "numToStr/Navigator.nvim", event = "VeryLazy", config = true },
  { "stevearc/dressing.nvim", event = "VeryLazy", opts = {} },

  {
    "mrjones2014/legendary.nvim",
  },
  {
    "folke/which-key.nvim",
    dependencies = {
      "echasnovski/mini.icons",
    },
    opts = {
      show_help = false,
      triggers = "auto",
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
  {
    "pechorin/any-jump.nvim",
    cmd = { "AnyJump", "AnyJumpVisual" },
    keys = {
      { "<leader>fj", "<cmd>AnyJump<CR>", mode = "n", desc = "AnyJump cursor" },
      { "<leader>fj", "<cmd>AnyJumpVisual<CR>", mode = "v", desc = "AnyJump selected" },
    },
    config = function()
      vim.g.any_jump_disable_default_keybindings = 1
    end,
  },
}
