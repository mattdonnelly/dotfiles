return {
  'nvim-tree/nvim-tree.lua',
  keys = {
    { '<leader>n', ':NvimTreeToggle<CR>' }
  },
  cmd = {
    'NvimTreeClipboard',
    'NvimTreeClose',
    'NvimTreeCollapse',
    'NvimTreeCollapseKeepBuffers',
    'NvimTreeFindFile',
    'NvimTreeFindFileToggle',
    'NvimTreeFocus',
    'NvimTreeOpen',
    'NvimTreeRefresh',
    'NvimTreeResize',
    'NvimTreeToggle',
  },
  config = {
    disable_netrw = true,
    ignore_ft_on_setup  = { 'startify', 'dashboard' },
    actions = {
      open_file = {
        quit_on_open  = true,
        resize_window = true
      }
    },
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
      width = 40,
    },
    renderer = {
      icons = {
        glyphs = {
          default = '',
          symlink = '',
        }
      }
    }
  }
}

-- vim.cmd('autocmd BufEnter * ++nested if winnr(\'$\') == 1 && bufname() == \'NvimTree_\' . tabpagenr() | quit | endif')
