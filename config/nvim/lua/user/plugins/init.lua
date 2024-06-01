return {
  "nathom/filetype.nvim",

  "RishabhRD/popfix",
  "RishabhRD/nvim-lsputils",
  "williamboman/mason-lspconfig.nvim",

  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",

  { "kdheepak/lazygit.nvim", cmd = { "LazyGit" } },
  { "psliwka/vim-smoothie", event = "BufWinEnter" },
  { "ntpeters/vim-better-whitespace", event = "BufReadPost" },
  { "j-hui/fidget.nvim", tag = "legacy", event = "VeryLazy", config = true },
  { "numToStr/Navigator.nvim", event = "VeryLazy", config = true },
  { "stevearc/dressing.nvim", event = "VeryLazy", opts = {} },

  {
    "tpope/vim-surround",
    event = "VeryLazy",
    dependencies = { "tpope/vim-repeat" },
  },
  {
    "mrjones2014/legendary.nvim",
  },
  {
    "folke/which-key.nvim",
    config = {
      show_help = false,
      triggers = "auto",
      plugins = {
        registers = false,
      },
      key_labels = { ["<leader>"] = "SPC" },
    },
  },
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle", "UndotreeShow", "UndotreeHide", "UndotreeFocus" },
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
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = true,
  },
  {
    "pechorin/any-jump.nvim",
    cmd = { "AnyJump", "AnyJumpVisual" },
    config = function()
      vim.g.any_jump_disable_default_keybindings = 1
    end,
  },
  {
    "Wansmer/treesj",
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = { use_default_keymaps = false },
  },
}
