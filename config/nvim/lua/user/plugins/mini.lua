return {
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    config = true,
  },
  {
    "echasnovski/mini.cursorword",
    event = "VeryLazy",
    opts = {
      delay = 500,
    },
  },
  {
    "echasnovski/mini-git",
    version = false,
    main = "mini.git",
    cmd = "Git",
    keys = {
      { "<leader>ga", "<CMD>Git add %<CR>", desc = "Git add buffer" },
      { "<leader>gA", "<CMD>Git add -A<CR>", desc = "Git add all files" },
      { "<leader>gc", "<CMD>Git commit<CR>", desc = "Git commit" },
      { "<leader>gd", "<CMD>Git diff %<CR>", desc = "Git diff buffer" },
      { "<leader>gD", "<CMD>Git diff<CR>", desc = "Git diff all files" },
      { "<leader>gr", "<CMD>Git reset %<CR>", desc = "Git reset buffer" },
      { "<leader>gs", "<CMD>Git status<CR>", desc = "Git status" },
    },
    config = true,
  },
  {
    "echasnovski/mini.indentscope",
    event = { "BufReadPre", "BufNewFile" },
    opts = function(_, opts)
      opts.draw = {
        delay = 0,
        animation = require("mini.indentscope").gen_animation.none(),
      }
      opts.options = { try_as_border = true }
      opts.symbol = "▏"
    end,
  },
  {
    "echasnovski/mini.move",
    version = false,
    event = "VeryLazy",
    opts = {
      mappings = {
        left = "<C-h>",
        right = "<C-l>",
        down = "<C-j>",
        up = "<C-k>",
        line_left = "<C-h>",
        line_down = "<C-j>",
        line_up = "<C-k>",
        line_right = "<C-l>",
      },
    },
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = true,
  },
  {
    "echasnovski/mini.splitjoin",
    event = "VeryLazy",
    opts = {
      mappings = {
        toggle = "gJ",
      },
    },
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    config = true,
  },
  {
    "echasnovski/mini.trailspace",
    event = "BufReadPost",
    config = true,
  },
}
