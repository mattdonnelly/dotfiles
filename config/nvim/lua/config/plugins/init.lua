local plugins = {
  'nathom/filetype.nvim',

  'RishabhRD/popfix',
  'RishabhRD/nvim-lsputils',
  'williamboman/mason-lspconfig.nvim',

  'nvim-lua/popup.nvim',
  'nvim-lua/plenary.nvim',

  { 'christoomey/vim-tmux-navigator', event = 'VeryLazy' },
  { 'tpope/vim-surround', event = 'VeryLazy' },
  {
    'folke/which-key.nvim',
    event = 'BufReadPost',
    config = {
      show_help = false,
      triggers = 'auto',
      plugins = { spelling = true },
      key_labels = { ['<leader>'] = 'SPC' },
    }
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    config = true,
  },
  {
    'mbbill/undotree',
    cmd = { 'UndotreeToggle', 'UndotreeShow', 'UndotreeHide', 'UndotreeFocus' },
    keys = {
      { '<leader>u', ':UndotreeToggle<CR>' }
    },
  },
  {
    'pechorin/any-jump.nvim',
    cmd = 'AnyJump',
    keys = { '<leader>j', '<cmd>AnyJump<CR>', desc = 'Open AnyJump' }
  },
  { 'ntpeters/vim-better-whitespace', event = 'BufRead' },
  { 'psliwka/vim-smoothie', event = 'BufWinEnter' },
  {
    'petertriho/nvim-scrollbar',
    event = 'BufWinEnter',
    config = true,
  },
  {
    'numToStr/Comment.nvim',
    event = 'BufReadPost',
    keys = { "gc", "gb" },
    dependencies = {
      'nvim-treesitter/nvim-treesitter'
    },
    config = function()
      local ts_comment_integration = require('ts_context_commentstring.integrations.comment_nvim')
      require('Comment').setup({
        pre_hook = ts_comment_integration.create_pre_hook(),
      })
    end
  },
  {
    'vim-test/vim-test',
    keys = { '<leader>t', '<leader>s', '<leader>l' },
    dependencies = {
      'voldikss/vim-floaterm',
    },
    config = function()
      vim.keymap.set('n', '<leader>tt', ':TestFile<CR>')
      vim.keymap.set('n', '<leader>tn', ':TestNearest<CR>')
      vim.keymap.set('n', '<leader>tl', ':TestLast<CR>')
      vim.g['test#strategy'] = {
        nearest = 'floaterm',
        file = 'floaterm',
        suite = 'basic',
      }
    end
  }
}

local has_local_plugins, local_plugins = pcall(require, 'local.plugins')
if has_local_plugins then
  table.move(local_plugins, 1, #local_plugins, #plugins + 1, plugins)
end

return plugins
