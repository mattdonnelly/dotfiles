return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Oil",
  keys = {
    { "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
  },
  opts = {
    lsp_file_methods = {
      autosave_changes = true,
    },
    view_options = {
      show_hidden = true,
    },
  },
}
