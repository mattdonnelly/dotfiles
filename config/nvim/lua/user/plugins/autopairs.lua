  return {
    'windwp/nvim-autopairs',
    dependencies = {
      'hrsh7th/nvim-cmp',
      'nvim-treesitter/nvim-treesitter',
    },
    event = 'BufReadPre',
    config = function()
      local npairs = require('nvim-autopairs')
      npairs.setup({
        check_ts = true
      })
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end
  }
