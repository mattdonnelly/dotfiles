local M = {}

M.signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
-- M.signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

function M.setup()
  vim.diagnostic.config({
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
  })
  for type, icon in pairs(M.signs) do
    local hl_name = vim.fn.has("nvim-0.6") and "DiagnosticSign" or "LspDiagnosticsSign"
    local hl = hl_name .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

return M
