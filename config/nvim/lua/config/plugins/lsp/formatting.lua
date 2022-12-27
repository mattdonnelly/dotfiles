local M = {}

function M.setup()
  vim.lsp.handlers['textDocument/codeAction'] = require('lsputil.codeAction').code_action_handler
  vim.lsp.handlers['textDocument/references'] = require('lsputil.locations').references_handler
  vim.lsp.handlers['textDocument/definition'] = require('lsputil.locations').definition_handler
  vim.lsp.handlers['textDocument/declaration'] = require('lsputil.locations').declaration_handler
  vim.lsp.handlers['textDocument/typeDefinition'] = require('lsputil.locations').typeDefinition_handler
  vim.lsp.handlers['textDocument/implementation'] = require('lsputil.locations').implementation_handler
  vim.lsp.handlers['textDocument/documentSymbol'] = require('lsputil.symbols').document_handler
  vim.lsp.handlers['workspace/symbol'] = require('lsputil.symbols').workspace_handler

  return function(bufnr)
    vim.lsp.buf.format({
      filter = function(client)
        return client.name ~= 'tsserver' and client.name ~= 'solargraph' and client.name ~= 'ember'
      end,
      bufnr = bufnr,
    })
  end
end

return M
