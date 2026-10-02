return {
  "windwp/nvim-autopairs",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  event = "BufReadPre",
  config = function()
    local npairs = require("nvim-autopairs")
    npairs.setup({
      check_ts = require("user.features").treesitter,
    })
  end,
}
