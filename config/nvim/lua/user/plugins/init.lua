local plugins = {
  "nathom/filetype.nvim",

  "RishabhRD/popfix",
  "RishabhRD/nvim-lsputils",
  "williamboman/mason-lspconfig.nvim",

  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",

  { "folke/noice.nvim", event = "VeryLazy", config = true },
  { "numToStr/Navigator.nvim", event = "VeryLazy", config = true },
  {
    "tpope/vim-surround",
    event = "VeryLazy",
    dependencies = {
      "tpope/vim-repeat",
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
    "mbbill/undotree",
    cmd = { "UndotreeToggle", "UndotreeShow", "UndotreeHide", "UndotreeFocus" },
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
  {
    "vim-test/vim-test",
    cmd = { "TestFile", "TestNearest", "TestLast" },
    dependencies = {
      "voldikss/vim-floaterm",
    },
    config = function()
      vim.g["test#strategy"] = {
        nearest = "floaterm",
        file = "floaterm",
        suite = "basic",
      }
    end,
  },
}

local has_local_plugins, local_plugins = pcall(require, "local.plugins")
if has_local_plugins then
  for _, p in pairs(local_plugins) do
    table.insert(plugins, p)
  end
end

return plugins
