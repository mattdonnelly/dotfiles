return {
  "micmine/jumpwire.nvim",
  keys = {
    { "<leader>mt", [[:lua require('jumpwire').jump('test')<CR>]] },
    { "<leader>mi", [[:lua require('jumpwire').jump('implementation')<CR>]] },
    { "<leader>mm", [[:lua require('jumpwire').jump('markup')<CR>]] },
    { "<leader>ms", [[:lua require('jumpwire').jump('style')<CR>]] },
  },
}
