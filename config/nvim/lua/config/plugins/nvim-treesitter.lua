return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'BufReadPost',
  dependencies = {
    'windwp/nvim-ts-autotag',
    'RRethy/nvim-treesitter-endwise',
    'JoosepAlviste/nvim-ts-context-commentstring',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      highlight = {
        enable = true,
        use_languagetree = true
      },
      ensure_installed = {
        'javascript',
        'html',
        'css',
        'ruby',
        'lua'
      },
      endwise = {
        enable = true,
      },
    })
    require('nvim-ts-autotag').setup()
  end
}
