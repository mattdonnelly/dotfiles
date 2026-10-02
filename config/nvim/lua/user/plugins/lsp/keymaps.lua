local M = {}

function M.setup()
  vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end,
    { desc = "Previous diagnostic" })
  vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next diagnostic" })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(event)
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = event.buf
        vim.keymap.set(mode, l, r, opts)
      end

      map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
      map("n", "gd", function()
        require("telescope.builtin").lsp_definitions({ reuse_win = true })
      end, { desc = "Go to definition" })
      map("n", "gi", function()
        require("telescope.builtin").lsp_implementations({ reuse_win = true })
      end, { desc = "Go to implementation" })

      map("n", "grr", "<cmd>Telescope lsp_references<CR>", { desc = "Go to references" })
      map("n", "gt", function()
        require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
      end, { desc = "Go to type definition" })

      map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })

      map("n", "<leader>K", vim.lsp.buf.signature_help, { desc = "Signature help" })

      map("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename" })

      map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
      map({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run code lens" })
      map("n", "<leader>cC", function() vim.lsp.codelens.enable(true) end, { desc = "Refresh & display code lens" })

      if require("user.features").formatting then
        map({ "n", "v" }, "=", function()
          require("conform").format()
        end, { desc = "Format" })
      end

      map("n", "<leader>e", function()
        vim.diagnostic.open_float(nil, { border = "rounded", focusable = false, scope = "cursor" })
      end, { desc = "Show diagnostics" })
    end,
  })
end

return M
