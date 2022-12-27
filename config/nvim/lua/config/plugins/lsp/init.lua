return {
  'neovim/nvim-lspconfig',
  event = 'BufReadPre',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'jose-elias-alvarez/null-ls.nvim',
    'jose-elias-alvarez/typescript.nvim'
  },
  config = function()
    require('mason')
    require('config.plugins.lsp.diagnostics').setup()
    local lsp_formatting = require('config.plugins.lsp.formatting').setup()

    local lspconfig = require('lspconfig')
    local null_ls = require('null-ls')
    local null_ls_helpers = require('null-ls.helpers')

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)



    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      --Enable completion triggered by <c-x><c-o>
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      -- vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.diagnostic.open_float(0,{scope=\'line\'})')

      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      local opts = { noremap = true, silent = true }

      -- See `:help vim.lsp.*` for documentation on any of the below functions
      buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
      buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float(0,{scope=\'line\'})<CR>', opts)
      buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
      buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
      buf_set_keymap('n', '<space>=', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

      if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = bufnr,
          callback = function()
            lsp_formatting(bufnr)
          end,
        })
      end
    end

    local default_config = {
      capabilities = capabilities,
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }

    lspconfig.html.setup(default_config)
    lspconfig.cssls.setup(default_config)
    lspconfig.bashls.setup(default_config)
    lspconfig.vimls.setup(default_config)

    lspconfig.ember.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        on_attach(client, bufnr)
      end,
      root_dir = lspconfig.util.root_pattern('ember-cli-build.js')
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

    require('neodev').setup()
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

    require('typescript').setup({
      capabilities = capabilities,
      go_to_source_definition = {
        fallback = true, -- fall back to standard LSP definition on failure
      },
      server = {
        on_attach = function(client, bufnr)
          local opts = { noremap = true, silent = true }
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gs', ':TSLspOrganize<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', ':TSLspRenameFile<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'go', ':TSLspImportAll<CR>', opts)

          on_attach(client, bufnr)
        end,
        flags = {
          debounce_text_changes = 150,
        },
      }
    })

    local ember_template_lint = {
      name = 'ember-template-lint',
      method = null_ls.methods.FORMATTING,
      filetypes = { 'html.handlebars' },
      generator = null_ls_helpers.formatter_factory {
        args = { '--fix', '$FILENAME' },
        command = 'ember-template-lint',
      }
    }

    local command_resolver = require('null-ls.helpers.command_resolver')
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
      require('typescript.extensions.null-ls.code-actions'),
    }

    null_ls.setup({
      debug = true,
      sources = sources,
      on_attach = on_attach,
    })
  end
}
