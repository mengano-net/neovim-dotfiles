return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'morhetz/gruvbox'
  use 'lifepillar/vim-gruvbox8'
  use {'nvim-treesitter/nvim-treesitter', run = ":TSUpdate"}
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use 'cohama/lexima.vim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'
  use 'airblade/vim-gitgutter'
  use 'navarasu/onedark.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'shaunsingh/nord.nvim'
  use 'rcarriga/nvim-notify'
  use 'norcalli/nvim-colorizer.lua'
  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'onsails/lspkind-nvim'
  use 'glepnir/lspsaga.nvim'
  --
  use 'ntpeters/vim-better-whitespace'
  use 'rose-pine/neovim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'akinsho/toggleterm.nvim'
end)
