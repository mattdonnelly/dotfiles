local M = {}

function M.format(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name ~= "tsserver" and client.name ~= "solargraph" and client.name ~= "ember"
    end,
    bufnr = bufnr,
  })
end

function M.setup(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    local autocmd_group = "auto_format_" .. bufnr
    vim.api.nvim_create_augroup(autocmd_group, { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = autocmd_group,
      buffer = bufnr,
      desc = "Auto format buffer " .. bufnr .. " before save",
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

return M
