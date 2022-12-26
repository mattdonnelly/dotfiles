local lspconfig = require("lspconfig")
local cmp = require("cmp")
local null_ls = require("null-ls")
local null_ls_helpers = require("null-ls.helpers")
local luasnip = require('luasnip')

local lsp_symbols = {
  Text = "   (Text) ",
  Method = "   (Method)",
  Function = "   (Function)",
  Constructor = "   (Constructor)",
  Field = " ﴲ  (Field)",
  Variable = "[] (Variable)",
  Class = "   (Class)",
  Interface = " ﰮ  (Interface)",
  Module = "   (Module)",
  Property = " 襁 (Property)",
  Unit = "   (Unit)",
  Value = "   (Value)",
  Enum = " 練 (Enum)",
  Keyword = "   (Keyword)",
  Snippet = "   (Snippet)",
  Color = "   (Color)",
  File = "   (File)",
  Reference = "   (Reference)",
  Folder = "   (Folder)",
  EnumMember = "   (EnumMember)",
  Constant = " ﲀ  (Constant)",
  Struct = " ﳤ  (Struct)",
  Event = "   (Event)",
  Operator = "   (Operator)",
  TypeParameter = "   (TypeParameter)",
}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  formatting = {
    format = function(entry, item)
      item.kind = lsp_symbols[item.kind]
      item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        neorg = "[Neorg]",
      })[entry.source.name]

      return item
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        return
      end
      fallback()
    end
      , { 'i', 'c' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
        return
      end
      fallback()
    end
      , { 'i', 'c' }),
  }),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'buffer', keyword_length = 3 },
    { name = 'luasnip', keyword_length = 2 },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  completion = {
    autocomplete = false,
  }
})

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.cmd [[highlight! default link CmpItemKind CmpItemMenuDefault]]

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.handlers["textDocument/codeAction"] = require "lsputil.codeAction".code_action_handler
vim.lsp.handlers["textDocument/references"] = require "lsputil.locations".references_handler
vim.lsp.handlers["textDocument/definition"] = require "lsputil.locations".definition_handler
vim.lsp.handlers["textDocument/declaration"] = require "lsputil.locations".declaration_handler
vim.lsp.handlers["textDocument/typeDefinition"] = require "lsputil.locations".typeDefinition_handler
vim.lsp.handlers["textDocument/implementation"] = require "lsputil.locations".implementation_handler
vim.lsp.handlers["textDocument/documentSymbol"] = require "lsputil.symbols".document_handler
vim.lsp.handlers["workspace/symbol"] = require "lsputil.symbols".workspace_handler

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
-- local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
  local hl_name = vim.fn.has("nvim-0.6") and "DiagnosticSign" or "LspDiagnosticsSign"
  local hl = hl_name .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name ~= "tsserver" and client.name ~= "solargraph" and client.name ~= "ember"
    end,
    bufnr = bufnr,
  })
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  --Enable completion triggered by <c-x><c-o>
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.diagnostic.open_float(0,{scope=\'line\'})')

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float(0,{scope=\'line\'})<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<space>=", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
end

-- Use a loop to conveniently call "setup" on multiple servers and
-- map buffer local keybindings when the language server attaches
local default_config = {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  }
}

lspconfig.ember.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    on_attach(client, bufnr)
  end,
  root_dir = lspconfig.util.root_pattern("ember-cli-build.js")
})
lspconfig.solargraph.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end,
  flags = {
    debounce_text_changes = 150,
  },
  init_options = {
    formatting = true
  },
  settings = {
    solargraph = {
      formatting = false
    }
  }
})
lspconfig.html.setup(default_config)
lspconfig.cssls.setup(default_config)
lspconfig.bashls.setup(default_config)

require("neodev").setup()

lspconfig.sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      telemetry = {
        enable = false,
      },
    }
  },
})

-- lspconfig.jsonls.setup(default_config))
lspconfig.vimls.setup(default_config)
require('typescript').setup({
  capabilities = capabilities,
  go_to_source_definition = {
    fallback = true, -- fall back to standard LSP definition on failure
  },
  server = {
    on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true }
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspRenameFile<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "go", ":TSLspImportAll<CR>", opts)

      on_attach(client, bufnr)
    end,
    flags = {
      debounce_text_changes = 150,
    },
  }
})

local ember_template_lint = {
  name = "ember-template-lint",
  method = null_ls.methods.FORMATTING,
  filetypes = { "html.handlebars" },
  generator = null_ls_helpers.formatter_factory {
    args = { "--fix", "$FILENAME" },
    command = "ember-template-lint",
  }
}

local command_resolver = require("null-ls.helpers.command_resolver")
local sources = {
  ember_template_lint,
  null_ls.builtins.formatting.prettier.with({
    disabled_filetypes = { 'html.handlebars', 'json' },
    dynamic_command = command_resolver.from_node_modules()
  }),
  null_ls.builtins.diagnostics.eslint.with({
    dynamic_command = command_resolver.from_node_modules()
  }),
  null_ls.builtins.code_actions.eslint.with({
    dynamic_command = command_resolver.from_node_modules()
  }),
  null_ls.builtins.formatting.rubocop,
  null_ls.builtins.diagnostics.rubocop,
  require("typescript.extensions.null-ls.code-actions"),
}

null_ls.setup({
  debug = true,
  sources = sources,
  on_attach = on_attach,
})
