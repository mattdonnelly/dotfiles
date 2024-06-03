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
      { "<leader>gC", "<CMD>Git commit<CR>", desc = "Git commit" },
      { "<leader>gd", "<CMD>Git diff %<CR>", desc = "Git diff buffer" },
      { "<leader>gD", "<CMD>Git diff<CR>", desc = "Git diff all files" },
      { "<leader>gr", "<CMD>Git reset %<CR>", desc = "Git reset buffer" },
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
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "diagmsg",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
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
