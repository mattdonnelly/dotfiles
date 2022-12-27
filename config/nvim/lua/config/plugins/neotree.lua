vim.g['neo_tree_remove_legacy_commands'] = 1

return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'Neotree',
  keys = {
    { '<leader>n', '<cmd>Neotree toggle<cr>', desc = 'NeoTree' },
  },
  version = 'v2.x',
  dependencies = {
    'MunifTanjim/nui.nvim'
  },
  config = {
    filesystem = {
      follow_current_file = true,
      hijack_netrw_behavior = 'open_current',
    },
  },
}
