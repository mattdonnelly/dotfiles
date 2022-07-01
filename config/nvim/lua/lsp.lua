local lspconfig = require("lspconfig")
local null_ls = require("null-ls")
local null_ls_helpers = require("null-ls.helpers")
local ts_utils = require("nvim-lsp-ts-utils")

vim.g.coq_settings = {
  auto_start = "shut-up",
  clients = {
    lsp = {
      resolve_timeout = 5000
    }
  }
}
local coq = require("coq")

vim.lsp.handlers["textDocument/codeAction"] = require"lsputil.codeAction".code_action_handler
vim.lsp.handlers["textDocument/references"] = require"lsputil.locations".references_handler
vim.lsp.handlers["textDocument/definition"] = require"lsputil.locations".definition_handler
vim.lsp.handlers["textDocument/declaration"] = require"lsputil.locations".declaration_handler
vim.lsp.handlers["textDocument/typeDefinition"] = require"lsputil.locations".typeDefinition_handler
vim.lsp.handlers["textDocument/implementation"] = require"lsputil.locations".implementation_handler
vim.lsp.handlers["textDocument/documentSymbol"] = require"lsputil.symbols".document_handler
vim.lsp.handlers["workspace/symbol"] = require"lsputil.symbols".workspace_handler

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
  local hl_name = vim.fn.has("nvim-0.6") and "DiagnosticSign" or "LspDiagnosticsSign"
  local hl = hl_name .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  --Enable completion triggered by <c-x><c-o>
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap=true, silent=true }

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
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<space>=", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  if client.resolved_capabilities.document_formatting then
    vim.cmd([[
      augroup LspFormatting
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 2000)
      augroup END
    ]])
  end
end

-- Use a loop to conveniently call "setup" on multiple servers and
-- map buffer local keybindings when the language server attaches
local default_config = {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  }
}

lspconfig.ember.setup(coq.lsp_ensure_capabilities({
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    on_attach(client, bufnr)
  end,
  root_dir = lspconfig.util.root_pattern("ember-cli-build.js")
}))
lspconfig.solargraph.setup(coq.lsp_ensure_capabilities({
  on_attach = function(client, bufnr) 
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
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
}))
lspconfig.html.setup(coq.lsp_ensure_capabilities(default_config))
lspconfig.cssls.setup(coq.lsp_ensure_capabilities(default_config))
lspconfig.bashls.setup(coq.lsp_ensure_capabilities(default_config))
-- lspconfig.jsonls.setup(coq.lsp_ensure_capabilities(default_config))
lspconfig.vimls.setup(coq.lsp_ensure_capabilities(default_config))
lspconfig.tsserver.setup(coq.lsp_ensure_capabilities({
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    ts_utils.setup({
      import_all_timeout = 5000,
      import_all_priorities = {
        same_file = 1,
        local_files = 2,
        buffer_content = 3,
        buffers = 4,
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,
    })
    ts_utils.setup_client(client)

    local opts = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspRenameFile<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "go", ":TSLspImportAll<CR>", opts)

    on_attach(client, bufnr)
  end,
  flags = {
    debounce_text_changes = 150,
  },
}))

local ember_template_lint = {
  name = "ember-template-lint",
  method = null_ls.methods.FORMATTING,
  filetypes = { "html.handlebars" },
  generator = null_ls_helpers.formatter_factory {
    args = { "--fix", "$FILENAME" },
    command = "ember-template-lint",
  }
}

local sources = {
  ember_template_lint,
  null_ls.builtins.formatting.prettier.with({
    disabled_filetypes = { 'html.handlebars' },
    dynamic_command = require("null-ls.helpers.command_resolver").from_node_modules
  }),
  null_ls.builtins.diagnostics.eslint.with({
    dynamic_command = require("null-ls.helpers.command_resolver").from_node_modules
  }),
  null_ls.builtins.code_actions.eslint.with({
    dynamic_command = require("null-ls.helpers.command_resolver").from_node_modules
  }),
  null_ls.builtins.formatting.rubocop,
  null_ls.builtins.diagnostics.rubocop,
}

null_ls.setup({
  sources = sources,
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
      augroup NullLsFormatting
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 2000)
      augroup END
      ]])
    end
  end,
})
