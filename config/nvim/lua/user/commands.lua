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

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    vim.cmd("FormatWrite")
  end,
})

vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "BufEnter" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
