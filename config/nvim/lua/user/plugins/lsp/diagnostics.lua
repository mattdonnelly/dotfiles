local M = {}

M.signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
-- M.signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

function M.setup()
  local severity = vim.diagnostic.severity

  vim.diagnostic.config({
    signs = {
      text = {
        [severity.ERROR] = M.signs.Error,
        [severity.WARN] = M.signs.Warning,
        [severity.INFO] = M.signs.Information,
        [severity.HINT] = M.signs.Hint,
      },
      numhl = {
        [severity.ERROR] = "DiagnosticSignError",
        [severity.WARN] = "DiagnosticSignWarn",
        [severity.INFO] = "DiagnosticSignInfo",
        [severity.HINT] = "DiagnosticSignHint",
      },
    },
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 2, prefix = "●" },
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = true,
      header = "",
      prefix = "",
    },
  })
end

return M
