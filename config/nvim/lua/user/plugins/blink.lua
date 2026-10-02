return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  version = "1.*",
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = {
    keymap = {
      preset = "none",
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    completion = {
      list = { selection = { preselect = false, auto_insert = false } },
      ghost_text = { enabled = true },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    cmdline = {
      enabled = true,
    },
  },
}
