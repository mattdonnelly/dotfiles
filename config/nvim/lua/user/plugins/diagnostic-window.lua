return {
  "cseickel/diagnostic-window.nvim",
  dependencies = {
    { "MunifTanjim/nui.nvim", branch = "main" },
  },
  event = "LspAttach",
  cmd = { "DiagWindowShow" },
  keys = {
    { "<leader>E", "<cmd>DiagWindowShow<CR>", desc = "Show diagnostic in window" },
  },
}
