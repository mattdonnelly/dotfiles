return {
  {
    "echasnovski/mini.ai",
    version = false,
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.cursorword",
    version = false,
    event = "VeryLazy",
    opts = {
      delay = 500,
    },
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
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
    "echasnovski/mini.pairs",
    version = false,
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.splitjoin",
    version = false,
    event = "VeryLazy",
    opts = {
      mappings = {
        toggle = "gJ",
      },
    },
  },
  {
    "echasnovski/mini.surround",
    version = false,
    event = "VeryLazy",
    opts = {},
  },
  {
    "echasnovski/mini.trailspace",
    version = false,
    event = "BufReadPost",
    opts = {},
  },
}
