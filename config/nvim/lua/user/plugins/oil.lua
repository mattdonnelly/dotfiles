return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = function()
    return {
      {
        "-",
        require("oil").open,
        desc = "Open parent directory",
      },
    }
  end,
  opts = {
    lsp_file_methods = {
      autosave_changes = true,
    },
    view_options = {
      show_hidden = true,
    },
  },
}
