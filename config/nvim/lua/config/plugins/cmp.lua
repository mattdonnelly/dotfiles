return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-path',
    'folke/neodev.nvim',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local has_copilot, _ = pcall(require, 'copilot_cmp')

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

    local sources = {
      { name = 'path', group_index = 2 },
      { name = 'nvim_lsp', group_index = 2 },
      { name = 'buffer', group_index = 2 },
      { name = 'luasnip', group_index = 2 },
    }

    if has_copilot then
      table.insert(sources, 1, { name = 'copilot', group_index = 2, max_item_count = 3 })
    end

    local check_backspace = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<C-e>'] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm { select = false },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.jumpable(1) then
            luasnip.jump(1)
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif luasnip.expandable() then
            luasnip.expand({ trigger = '<Tab>' })
          elseif check_backspace() then
            fallback()
          else
            fallback()
          end
        end
          , { 'i', 'c' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end
          , { 'i', 'c' }),
      }),
      sources = cmp.config.sources(sources),
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      formatting = {
        format = function(entry, item)

          if entry.source.name == "copilot" then
            item.kind = '  (Copilot)'
          else
            item.kind = lsp_symbols[item.kind]
          end
          item.menu = ({
            buffer = "[Buffer]",
            copilot = "[Copilot]",
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            neorg = "[Neorg]",
          })[entry.source.name]

          return item
        end
      },
      experimental = {
        ghost_text = true,
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
        autocomplete = {},
      }
    })
  end
}
