local parsers = {
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
  "json",
  "latex",
  "lua",
  "markdown",
  "markdown_inline",
  "meson",
  "ninja",
  "nix",
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
}

return {
  "nvim-treesitter/nvim-treesitter",
  enabled = require("user.features").treesitter,
  branch = "main",
  -- The main branch does not support lazy-loading
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "RRethy/nvim-treesitter-endwise",
  },
  config = function()
    local ts = require("nvim-treesitter")
    ts.install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("UserTreesitter", {}),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if not lang then
          return
        end

        local function start()
          if vim.api.nvim_buf_is_valid(args.buf) then
            pcall(vim.treesitter.start, args.buf, lang)
          end
        end

        -- Install missing parsers on demand (replaces master's `auto_install`)
        if
          not vim.list_contains(ts.get_installed(), lang)
          and vim.list_contains(ts.get_available(), lang)
        then
          ts.install(lang):await(vim.schedule_wrap(start))
        else
          start()
        end
      end,
    })

    require("nvim-ts-autotag").setup()
  end,
}
