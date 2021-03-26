local keymap = vim.api.nvim_set_keymap
keymap("n", "<leader>n", ":NvimTreeToggle<CR>", {})

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_width = 40
vim.g.nvim_tree_ignore = { '.git', '.cache' }
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_auto_ignore_ft = { 'startify', 'dashboard' }
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_disable_netrw = 1
vim.g.nvim_tree_hide_dotfiles = 0
vim.g.nvim_tree_allow_resize = 1
vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
}
