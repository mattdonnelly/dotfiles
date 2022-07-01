local keymap = vim.api.nvim_set_keymap
keymap("n", "<leader>n", ":NvimTreeToggle<CR>", {})

require('nvim-tree').setup {
  disable_netrw       = true,
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

vim.cmd('autocmd BufEnter * ++nested if winnr(\'$\') == 1 && bufname() == \'NvimTree_\' . tabpagenr() | quit | endif')
