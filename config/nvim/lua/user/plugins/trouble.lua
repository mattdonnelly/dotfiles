return {
  "folke/trouble.nvim",
  cmd = { "Trouble", "TroubleClose", "TroubleRefresh", "TroubleToggle" },
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble diagnostics" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble current buffer" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble loclist" },
    { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "Trouble quickfix" },
    {
      "<leader>xs",
      "<cmd>Trouble symbols toggle focus=false win.size=0.25<cr>",
      desc = "Trouble symbols",
    },
    {
      "<leader>xc",
      "<cmd>Trouble lsp toggle focus=false win.position=right win.size=0.25<cr>",
      desc = "Trouble LSP references/definitions/...",
    },
  },
  config = true,
}
