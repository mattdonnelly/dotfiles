local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    print('Installed packer. Close and reopen Neovim...')
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

local packer_auto_compile = vim.api.nvim_create_augroup('packer_auto_compile', {})

vim.api.nvim_create_autocmd('BufWritePost', {
  group = packer_auto_compile,
  pattern = '*/nvim/lua/plugins.lua',
  callback = function(ctx)
    local cmd = 'source ' .. ctx.file
    vim.cmd(cmd)
    vim.cmd('PackerCompile')
    vim.notify('PackerCompile done!', vim.log.levels.INFO, { title = 'Nvim-config' })
  end,
})

packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
})

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'nathom/filetype.nvim'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  use {
    'neovim/nvim-lspconfig',
    'RishabhRD/popfix',
    'RishabhRD/nvim-lsputils',
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'folke/neodev.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require("luasnip.loaders.from_lua").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load()
      require('lsp')
    end
  }

  use {
    'windwp/nvim-autopairs',
    requires = {
      'hrsh7th/nvim-cmp',
      'nvim-treesitter/nvim-treesitter',
    },
    event = 'BufReadPre',
    config = function()
      local npairs = require('nvim-autopairs')
      npairs.setup({
        check_ts = true
      })
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end
  }

  use {
    'RRethy/nvim-treesitter-endwise',
    'windwp/nvim-ts-autotag',
    'JoosepAlviste/nvim-ts-context-commentstring',
    requires = {
      'nvim-treesitter/nvim-treesitter'
    },
    config = function()
      require('plugins.nvim-treesitter')
      require('nvim-ts-autotag').setup()
    end
  }

  use {
    'glepnir/dashboard-nvim',
    config = function()
      require('plugins.dashboard')
    end
  }

  use {
    'famiu/feline.nvim',
    config = function()
      require('plugins.feline')
    end
  }

  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins.nvim-web-devicons')
    end
  }

  use {
    'romgrk/barbar.nvim',
    requires = { 'nvim-web-devicons' },
    config = function()
      require('bufferline').setup {
        clickable = true,
        exclude_ft = { 'qf', 'nerdtree' }
      }
    end
  }

  use {
    'folke/tokyonight.nvim',
    config = function()
      vim.cmd('colorscheme tokyonight-night')
    end
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    'jose-elias-alvarez/typescript.nvim'
  }
  use {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    config = function()
      require('gitsigns').setup()
    end
  }
  use 'christoomey/vim-tmux-navigator'
  use 'tpope/vim-surround'
  use {
    'mbbill/undotree',
    opt = true,
    cmd = { 'UndotreeToggle', 'UndotreeShow', 'UndotreeHide', 'UndotreeFocus' },
    keys = { '<leader>u' },
    config = function()
      vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>', { silent = true })
    end
  }
  use {
    'ggandor/lightspeed.nvim',
    config = function()
      require('plugins.lightspeed')
    end
  }
  use 'pechorin/any-jump.nvim'

  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.0',
    requires = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep',
      'sharkdp/fd',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
    config = function()
      require('plugins.telescope')
    end
  }

  use {
    'nvim-tree/nvim-tree.lua',
    cmd = {
      'NvimTreeClipboard',
      'NvimTreeClose',
      'NvimTreeCollapse',
      'NvimTreeCollapseKeepBuffers',
      'NvimTreeFindFile',
      'NvimTreeFindFileToggle',
      'NvimTreeFocus',
      'NvimTreeOpen',
      'NvimTreeRefresh',
      'NvimTreeResize',
      'NvimTreeToggle',
    },
    keys = { '<leader>n' },
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require('plugins.nvim-tree')
    end
  }

  use { 'ntpeters/vim-better-whitespace' }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('plugins.indent-blankline')
    end
  }

  use 'psliwka/vim-smoothie'
  use {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup()
    end
  }

  use 'voldikss/vim-floaterm'

  use {
    'micmine/jumpwire.nvim',
    config = function()
      vim.keymap.set('n', '<leader>mt', [[:lua require('jumpwire').jump('test')<CR>]])
      vim.keymap.set('n', '<leader>mi', [[:lua require('jumpwire').jump('implementation')<CR>]])
      vim.keymap.set('n', '<leader>mm', [[:lua require('jumpwire').jump('markup')<CR>]])
      vim.keymap.set('n', '<leader>ms', [[:lua require('jumpwire').jump('style')<CR>]])
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
      local ts_comment_integration = require('ts_context_commentstring.integrations.comment_nvim')
      require('Comment').setup({
        pre_hook = ts_comment_integration.create_pre_hook(),
      })
    end
  }

  use {
    'folke/trouble.nvim',
    config = function()
      require('plugins.trouble')
    end
  }

  use {
    'vim-test/vim-test',
    keys = { '<leader>t', '<leader>s', '<leader>l' },
    config = function()
      vim.keymap.set('n', '<leader>tt', ':TestFile<CR>')
      vim.keymap.set('n', '<leader>tn', ':TestNearest<CR>')
      vim.keymap.set('n', '<leader>tl', ':TestLast<CR>')
      vim.g['test#strategy'] = {
        nearest = 'floaterm',
        file = 'floaterm',
        suite = 'basic',
      }
    end
  }

  local has_local_plugins, local_plugins = pcall(require, 'local.plugins')
  if has_local_plugins then
    local_plugins.setup(use)
  end

  if packer_bootstrap then
    require('packer').sync()
  end
end)
