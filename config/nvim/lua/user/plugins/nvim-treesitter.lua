return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = "BufReadPost",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "RRethy/nvim-treesitter-endwise",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      auto_install = true,
      sync_install = false,
      modules = {},
      ignore_install = {},
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "diff",
        "fish",
        "gitignore",
        "go",
        "graphql",
        "glimmer",
        "glimmer_javascript",
        "glimmer_typescript",
        "html",
        "http",
        "java",
        "javascript",
        "jsdoc",
        "jsonc",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "meson",
        "ninja",
        "nix",
        "norg",
        "org",
        "php",
        "python",
        "query",
        "regex",
        "rust",
        "scss",
        "sql",
        "svelte",
        "teal",
        "toml",
        "tsx",
        "typescript",
        "vhs",
        "vim",
        "vimdoc",
        "vue",
        "wgsl",
        "yaml",
        "json",
      },
      endwise = {
        enable = true,
      },
    })
    require("nvim-ts-autotag").setup()
  end,
}
