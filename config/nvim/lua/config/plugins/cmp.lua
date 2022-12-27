return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-path',
    'folke/neodev.nvim',
    'saadparwaiz1/cmp_luasnip',
  },
  config = function()
    local cmp = require('cmp')

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

    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    vim.cmd([[highlight! default link CmpItemKind CmpItemMenuDefault]])

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
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
      }),
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
    })

    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'cmp_git' },
      }, {
        { name = 'buffer' },
      })
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

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
  end
}
