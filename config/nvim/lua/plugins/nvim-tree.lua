local keymap = vim.api.nvim_set_keymap
keymap("n", "<leader>n", ":NvimTreeToggle<CR>", {})

vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
}
require('nvim-tree').setup {
  open_on_setup       = false,
  disable_netrw       = true,
  auto_close          = true,
  ignore_ft_on_setup  = { 'startify', 'dashboard' },
  diagnostics = {
    enable = true,
  },
  update_focused_file = {
    enable = true,
  },
  filters = {
    dotfiles = false,
    custom = { '.git', '.cache' }
  },
  view = {
    width       = 40,
    auto_resize = true
  },
}
