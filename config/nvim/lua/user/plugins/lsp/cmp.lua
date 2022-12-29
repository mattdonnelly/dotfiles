local M = {}

function M.setup(lsp)
  local cmp = require("cmp")

  local sources = {
    { name = "path", group_index = 2 },
    { name = "nvim_lsp", group_index = 2 },
    { name = "buffer", group_index = 2 },
    { name = "luasnip", group_index = 2 },
  }

  if vim.g.copilot_enabled then
    table.insert(sources, 1, { name = "copilot", group_index = 2, max_item_count = 3 })
  end

  lsp.setup_nvim_cmp({
    sources = sources,
    mapping = lsp.defaults.cmp_mappings({
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
    }),
  })
end

return M
