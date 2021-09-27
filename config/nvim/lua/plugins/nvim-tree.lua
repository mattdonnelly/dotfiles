local keymap = vim.api.nvim_set_keymap
keymap("n", "<leader>n", ":NvimTreeToggle<CR>", {})

vim.g.nvim_tree_ignore = { '.git', '.cache' }
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_hide_dotfiles = 0
vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
}
require('nvim-tree').setup {
  open_on_setup       = false,
  disable_netrw       = true,
  auto_close          = true,
  lsp_diagnostics     = true,
  ignore_ft_on_setup  = { 'startify', 'dashboard' },
  update_focused_file = {
    enable = true,
  },
  view = {
    width       = 40,
    auto_resize = true
  },
}
