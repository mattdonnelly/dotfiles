local M = {}

function M.setup(bufnr)
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { bufnr = bufnr, desc = "Go to definition" })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { bufnr = bufnr, desc = "Go to declaration" })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { bufnr = bufnr, desc = "Go to implementation" })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { bufnr = bufnr, desc = "Go to references" })
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { bufnr = bufnr, desc = "Go to type definition" })

  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })

  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { bufnr = bufnr, desc = "Previous diagnostic" })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { bufnr = bufnr, desc = "Next diagnostic" })

  vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })

  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { bufnr = bufnr, desc = "Rename" })
  vim.keymap.set("n", "<leader>C", vim.lsp.buf.code_action, { bufnr = bufnr, desc = "Code action" })

  vim.keymap.set({ "n", "v" }, "=", function()
    vim.lsp.buf.format({ async = true })
  end, { bufnr = bufnr, desc = "Format" })

  vim.keymap.set("n", "<leader>e", function()
    vim.diagnostic.open_float(nil, { border = "rounded", focusable = false, scope = "cursor" })
  end, { bufnr = bufnr, desc = "Show diagnostics" })
end

return M
