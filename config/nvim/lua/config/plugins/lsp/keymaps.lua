local M = {}

function M.setup(bufnr)
  local wk = require('which-key')

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local keymap = {
    buffer = bufnr,
    ['<leader>'] = {
      wa = { vim.lsp.buf.add_workspace_folder, 'Add workspace folder' },
      wr = { vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder' },
      wl = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'Inspect workspace folder' },
      rn = { vim.lsp.buf.rename, 'Rename' },
      ca = {
        { vim.lsp.buf.code_action, 'Run code action' },
        { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action', mode = 'v' },
      },
      ['='] = { function() vim.lsp.buf.format({ async = true }) end, 'Format' },
      e = { function() vim.diagnostic.open_float(nil, { border = 'rounded', focusable = false, scope = 'cursor' }) end, 'Show diagnostics' }
    },
    g = {
      name = '+goto',
      D = { vim.lsp.buf.declaration, 'Go to declaration' },
      d = { vim.lsp.buf.definition, 'Go to definition' },
      i = { vim.lsp.buf.implementation, 'Go to definition' },
      r = { vim.lsp.buf.references, 'Show references' },
      R = { '<cmd>Trouble lsp_references<cr>', 'Trouble references' },
      t = { vim.lsp.buf.type_definition, 'Type defintion' },
    },
    K = { vim.lsp.buf.hover, 'Hover' },
    ['<C-k>'] = { vim.lsp.buf.signature_help, 'Show signature', mode = { 'n', 'i' }  },
    ['[d'] = { vim.diagnostic.goto_prev, 'Previous diagnostic' },
    [']d'] = { vim.diagnostic.goto_next, 'Next diagnostic' },
  }

  wk.register(keymap)
end

return M
