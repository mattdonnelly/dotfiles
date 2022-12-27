return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  config = {
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
