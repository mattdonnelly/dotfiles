local M = {}

function M.setup()
  local signs = { Error = ' ', Warning = ' ', Hint = ' ', Information = ' ' }

  vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
  })
  -- local signs = { Error = ' ', Warning = ' ', Hint = ' ', Information = ' ' }
  for type, icon in pairs(signs) do
    local hl_name = vim.fn.has('nvim-0.6') and 'DiagnosticSign' or 'LspDiagnosticsSign'
    local hl = hl_name .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

return M
