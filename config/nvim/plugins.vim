call plug#begin('~/.local/share/nvim/plugged')

Plug 'glepnir/dashboard-nvim'
Plug 'famiu/feline.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'psliwka/vim-smoothie'
Plug 'folke/tokyonight.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
Plug 'lewis6991/gitsigns.nvim', { 'branch': 'main' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'ggandor/lightspeed.nvim'
Plug 'pechorin/any-jump.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'RRethy/nvim-treesitter-endwise'
Plug 'vim-test/vim-test'
Plug 'JoosepAlviste/nvim-ts-context-commentstring', { 'branch': 'main' }
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag', { 'branch': 'main' }
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'micmine/jumpwire.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'folke/trouble.nvim'
Plug 'petertriho/nvim-scrollbar'

if filereadable(glob("~/.config/nvim/plugins.local.vim"))
  source ~/.config/nvim/plugins.local.vim
endif

call plug#end()
