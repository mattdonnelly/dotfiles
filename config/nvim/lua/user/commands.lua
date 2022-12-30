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
