return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "BufReadPre",
  opt = {
    filetype_exclude = {
      "startify",
      "dashboard",
      "markdown",
      "pandoc",
      "vimwiki",
      "NeogitStatus",
      "help",
      "man",
      "tex",
    },
    char = "▏",
    show_first_indent_level = false,
    show_trailing_blankline_indent = false,
    use_treesitter = true,
  },
}
