local M = {}

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

function M.format(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name ~= 'tsserver' and client.name ~= 'solargraph' and client.name ~= 'ember'
    end,
    bufnr = bufnr,
  })
end

function M.setup(client, bufnr)
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        M.format(bufnr)
      end,
    })
  end
end

return M
