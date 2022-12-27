return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'Neotree',
  version = 'v2.x',
  dependencies = {
    'MunifTanjim/nui.nvim'
  },
  config = function()
    vim.g['neo_tree_remove_legacy_commands'] = 1

    local signs = require('config.plugins.lsp.diagnostics').signs
    vim.fn.sign_define('DiagnosticSignError', { text = signs.Error, texthl = 'DiagnosticSignError' })
    vim.fn.sign_define('DiagnosticSignWarn', { text = signs.Warning, texthl = 'DiagnosticSignWarn' })
    vim.fn.sign_define('DiagnosticSignInfo', { text = signs.Information, texthl = 'DiagnosticSignInfo' })
    vim.fn.sign_define('DiagnosticSignHint', { text = signs.Hint, texthl = 'DiagnosticSignHint' })

    require('neo-tree').setup({
      filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = 'open_current',
      },
      event_handlers = {
        {
          event = 'file_opened',
          handler = function()
            require('neo-tree').close_all()
          end
        },
      },
      window = {
        mappings = {
          ['<tab>'] = function(state)
            local node = state.tree:get_node()
            if require('neo-tree.utils').is_expandable(node) then
              state.commands['toggle_node'](state)
            else
              state.commands['open'](state)
              vim.cmd('Neotree reveal')
            end
          end,
        }
      }
    })
  end
}
