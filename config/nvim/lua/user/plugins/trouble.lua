return {
  "folke/trouble.nvim",
  opts = {},
  cmd = { "Trouble", "TroubleClose", "TroubleRefresh", "TroubleToggle" },
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", "Trouble diagnostics" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Trouble current buffer" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", "Trouble loclist" },
    { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", "Trouble quickfix" },
    { "<leader>xp", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "Trouble lsp references" },
  },
  config = true,
}
