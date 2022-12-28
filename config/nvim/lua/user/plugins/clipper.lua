local is_over_ssh = os.getenv("SSH_CLIENT")
local clipper_host = os.getenv("CLIPPER_HOST")
local clipper_port = os.getenv("CLIPPER_PORT")

return {
  "wincent/vim-clipper",
  cond = function()
    return is_over_ssh and clipper_host and clipper_port
  end,
  event = "VeryLazy",
  init = function()
    vim.g["ClipperMap"] = 0
  end,
  config = function()
    vim.fn["clipper#set_invocation"](table.concat({ "nc", clipper_host, clipper_port }, " "))
  end,
}
