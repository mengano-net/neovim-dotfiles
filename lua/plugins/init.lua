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
end)
