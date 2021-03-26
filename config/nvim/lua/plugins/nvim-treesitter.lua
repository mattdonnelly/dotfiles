require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    use_languagetree = true
  },
  ensure_installed = {
    "javascript",
    "html",
    "css",
    "ruby",
    "lua"
  },
}
