vim.api.nvim_create_autocmd("BufReadPost", {
  command = [[
    if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      exe "normal g`\"" |
    endif
  ]],
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "css", "scss", "sass" },
  command = "setlocal iskeyword+=-",
})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWritePre", {
  pattern = "*.ts,*.tsx,*.jsx,*.js",
  callback = function(args)
    local client = vim.lsp.get_clients({ bufnr = args.buf, name = "vtsls" })[1]
    if not client then
      return
    end

    local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
    params.context = { only = { "source.addMissingImports.ts" }, diagnostics = {} }

    local res = client:request_sync("textDocument/codeAction", params, 1000, args.buf)
    for _, action in ipairs(res and res.result or {}) do
      if not action.edit then
        local resolved = client:request_sync("codeAction/resolve", action, 1000, args.buf)
        action = resolved and resolved.result or action
      end
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
      end
    end
  end,
})
