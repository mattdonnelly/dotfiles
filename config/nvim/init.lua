-- .vimrc of Matt Donnelly

require("user.options")

require("user.lazy")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("user.commands")
    require("user.mappings")
  end,
})

pcall(require, "local.init")
