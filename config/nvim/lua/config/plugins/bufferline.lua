return {
  'akinsho/nvim-bufferline.lua',
  event = 'BufAdd',
  keys = {
    { 'gp', '<cmd>:BufferLineCyclePrev<CR>', desc = 'Previous buffer' },
    { 'gn', '<cmd>:BufferLineCycleNext<CR>', desc = 'Next buffer' },
  },
  config = function()
    local diagnostics = require('config.plugins.lsp.diagnostics')

    local signs = {
      error = diagnostics.signs.Error,
      warning = diagnostics.signs.Warning,
      hint = diagnostics.signs.Hint,
      info = diagnostics.signs.Information,
    }

    local severities = {
      'error',
      'warning',
    }

    require('bufferline').setup({
      options = {
        show_close_icon = true,
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
        separator_style = 'thick',
        diagnostics_indicator = function(_, _, diag)
          local s = {}
          for _, severity in ipairs(severities) do
            if diag[severity] then
              table.insert(s, signs[severity] .. diag[severity])
            end
          end
          return table.concat(s, ' ')
        end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo Tree',
            highlight = 'Directory',
            text_align = 'left',
          },
        },
      },
    })
  end
}
