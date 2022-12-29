local M = {}

M.signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
-- M.signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

function M.setup(lsp)
  lsp.set_preferences({
    configure_diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = { spacing = 4, prefix = "●" },
      severity_sort = true,
    },
    sign_icons = {
      error = M.signs.Error,
      warn = M.signs.Warning,
      hint = M.signs.Hint,
      info = M.signs.Information,
    },
  })
end

return M
