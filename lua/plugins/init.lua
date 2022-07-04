-- Automatically install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer; you need to close and reopen Neovim...")
end

-- Have packer use a popup window
-- require("packer").init({
--   display = {
--     open_fn = function()
--       return require("packer.util").float({ border = "rounded" })
--     end,
--   },
-- })

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- color schemes
  use({ "rose-pine/neovim" })

  use({
    "shaunsingh/nord.nvim",
    setup = {
      "vim.g.nord_contrast = true",
      "vim.g.nord_borders = true",
      "vim.g.nord_disable_background = true",
      "vim.g.nord_italic = true",
    },
    -- config = "vim.cmd('colorscheme nord')"
  })

  use({
    "navarasu/onedark.nvim",
    setup = {
      -- "vim.g.onedark_style = 'dark'",
    },
    config = {
      "require('onedark-config')",
      -- "vim.cmd('colorscheme onedark')",
    }
  })

  use({
    "folke/tokyonight.nvim",
    setup = { "vim.g.tokyonight_style = 'night'", "tokyonight_lualine_bold = 'true'" },
    -- config = "vim.cmd('colorscheme tokyonight')"
  })

  use({ "adisen99/apprentice.nvim", requires = { "rktjmp/lush.nvim" } })

  use({
    "ellisonleao/gruvbox.nvim",
    requires = { "rktjmp/lush.nvim" },
    setup = { "vim.g.gruvbox_contrast_dark = 'hard'" },
    -- config = "vim.cmd('colorscheme gruvbox')"
  })

  use({
    "marko-cerovac/material.nvim",
    -- setup = "vim.g.material_style = 'deep ocean'",
    setup = "vim.g.material_style = 'darker'",
    -- config = { "vim.cmd('colorscheme material')", "require('material-config')" }
    config = { "require('material-config')" },
  })

  use({
    "lunarvim/darkplus.nvim",
    config = "vim.cmd('colorscheme darkplus')"
  })

  use({
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    requires = "kyazdani42/nvim-web-devicons",
    config = { "require('bufferline-config')" },
  })
  -------------------------------------------------------------------------------------------------


  -- Better formatting, colors, auto pairs, etc
  use({ "windwp/nvim-autopairs", config = { "require('autopairs-config')" } })

  use({ "numToStr/Comment.nvim", config = "require('comment-config')" })

  -- This is now a treesitter module, it is NOT a standalone plugin, I will need to configure on
  -- treesitter
  use({ "p00f/nvim-ts-rainbow" })

  use({
    "norcalli/nvim-colorizer.lua",
    config = "require('colorizer').setup()",
  })

  use("ntpeters/vim-better-whitespace")

  use({ "lukas-reineke/indent-blankline.nvim", config = "require('blankline-config')" })

  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = "require('lualine-config')",
  })
  -------------------------------------------------------------------------------------------------


  -- Plugins that make this configuration a better IDE
  use("tpope/vim-fugitive")

  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = { "require('gitsigns-config')" },
    tag = 'release' -- To use the latest release
  })

  use({
    "ellisonleao/glow.nvim",
    branch = 'main',
    setup = { "vim.g.glow_border = 'rounded'" },
  })

  use({
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    config = {
      -- function() require'nvim-tree'.setup {} end,
      "require('nvimtree-config')",
    },
  })

  use({ "rcarriga/nvim-notify", config = "require('notify-extensions')" })

  use({
    "akinsho/toggleterm.nvim",
    tag = "v1.*",
    config = "require('toggleterm-config')",
  })

  use({
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = { "require('telescope-config')", "require('telescope-extensions')" },
  })

  --[[ This plugin has MANY key maps configured to call several of the plugins above, do NOT
  install it until the previous plugins are also installed and configured FIRST
  Such plugins are(not exhaustive): telescope, gitsigns, nvimTree, etc. ]]
  use({
    "folke/which-key.nvim",
    config = function()
      -- require("which-key").setup {}
      require("whichkey-config")
    end,
  })
  -------------------------------------------------------------------------------------------------


  -- Language servers, code formatting, autocompletion
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = "require('treesitter-config')",
  })

  use({
    "hrsh7th/nvim-cmp",
    config = "require('cmp-config')",
  })

  use("neovim/nvim-lspconfig")

  use({ "williamboman/nvim-lsp-installer" })

  use("hrsh7th/cmp-nvim-lsp")

  use("hrsh7th/cmp-buffer")

  use("hrsh7th/cmp-path")

  use("hrsh7th/cmp-cmdline")

  use("hrsh7th/cmp-vsnip")

  use({ "hrsh7th/vim-vsnip" })

  use({ "onsails/lspkind-nvim", config = "require('lspkind-config')" })


  -------------------------------------------------------------------------------------------------

  --
  --   use({ "jose-elias-alvarez/null-ls.nvim", config = "require('null-ls-config')" })
  --

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
