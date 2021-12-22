-- Automatically install packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print("Installing packer; you need to close and reopen Neovim...")
end

-- Have packer use a popup window
require("packer").init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- return require('packer').startup(function()
return require("packer").startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
    config = "require('treesitter-config')"
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = "require('lualine-config')"
  }
  use {'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = { "require('bufferline-config')" }
  }
  use { 'cohama/lexima.vim' }
  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = { "require('gitsigns-config')" }
    -- tag = 'release' -- To use the latest release
  }
  use 'tpope/vim-commentary'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = { "require('telescope-config')", "require('telescope-extensions')" }
  }
  use { 'rcarriga/nvim-notify', config = "require('notify-extensions')" }
  use {  'norcalli/nvim-colorizer.lua', config = "require('colorizer-config')" }

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
  use { 'onsails/lspkind-nvim', config = "require('lspkind-config')" }
  use { 'tami5/lspsaga.nvim', config = "require('lspsaga-config')" }
  use 'ntpeters/vim-better-whitespace'
  use { 'lukas-reineke/indent-blankline.nvim', config = "require('blankline-config')" }
  use { 'akinsho/toggleterm.nvim', config = "require('toggleterm-config')" }

  -- colorschemes
  use { 'rose-pine/neovim' }
  use 'shaunsingh/nord.nvim'
  use { 'navarasu/onedark.nvim', setup = "vim.g.onedark_style = 'deep'" }
  use {
    'folke/tokyonight.nvim',
    setup = { "vim.g.tokyonight_style = 'night'", "tokyonight_lualine_bold = 'true'" },
    -- config = "vim.cmd('colorscheme tokyonight')"
  }
  use { "adisen99/apprentice.nvim", requires = { "rktjmp/lush.nvim" } }
  use { "ellisonleao/gruvbox.nvim" }
  use {
    "marko-cerovac/material.nvim",
    -- setup = "vim.g.material_style = 'deep ocean'",
    setup = "vim.g.material_style = 'darker'",
    config = { "vim.cmd('colorscheme material')", "require('material-config')" }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
