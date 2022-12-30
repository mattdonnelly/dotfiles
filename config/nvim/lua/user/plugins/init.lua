return {
  "nathom/filetype.nvim",

  "RishabhRD/popfix",
  "RishabhRD/nvim-lsputils",
  "williamboman/mason-lspconfig.nvim",

  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",

  { "j-hui/fidget.nvim", event = "VeryLazy", config = true },
  { "numToStr/Navigator.nvim", event = "VeryLazy", config = true },
  {
    "tpope/vim-surround",
    event = "VeryLazy",
    dependencies = {
      "tpope/vim-repeat",
    },
  },
  {
    "mrjones2014/legendary.nvim",
    dependencies = {
      { "stevearc/dressing.nvim", config = true },
    },
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
    "SmiteshP/nvim-navic",
    config = function()
      vim.g.navic_silence = true
      require("nvim-navic").setup({ separator = " ", highlight = true, depth_limit = 5 })
    end,
  },
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle", "UndotreeShow", "UndotreeHide", "UndotreeFocus" },
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
      vim.g["any_jump_disable_default_keybindings"] = 1
    end,
  },
  { "ntpeters/vim-better-whitespace", event = "BufReadPost" },
  { "psliwka/vim-smoothie", event = "BufWinEnter" },
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    keys = { "gc", "gb" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local ts_comment_integration = require("ts_context_commentstring.integrations.comment_nvim")
      require("Comment").setup({
        pre_hook = ts_comment_integration.create_pre_hook(),
      })
    end,
  },
}
