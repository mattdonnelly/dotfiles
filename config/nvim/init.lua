-- .vimrc of Matt Donnelly

require("user.options")
pcall(require, "local.init")

require("user.lazy")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("user.commands")
    require("user.mappings")
  end,
})
