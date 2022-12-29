local is_over_ssh = os.getenv("SSH_CLIENT")
local clipper_host = vim.g.clipper_host
local clipper_port = vim.g.clipper_port

return {
  "wincent/vim-clipper",
  cond = is_over_ssh and clipper_host and clipper_port,
  event = "VeryLazy",
  init = function()
    vim.g.ClipperMap = 0
  end,
  config = function()
    vim.fn["clipper#set_invocation"](table.concat({ "nc", clipper_host, clipper_port }, " "))
  end,
}
