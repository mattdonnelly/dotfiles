return {
  "cseickel/diagnostic-window.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  event = "LspAttach",
  cmd = { "DiagWindowShow" },
  keys = {
    { "<leader>E", "<cmd>DiagWindowShow<CR>", desc = "Show diagnostic in window" },
  },
}
