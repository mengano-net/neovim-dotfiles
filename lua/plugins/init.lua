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
require("packer").init({
  display = {
    open_fn = function() return require("packer.util").float({ border = "rounded" }) end,
  },
})

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  ----------------------------------------------------------------------------------------
  -- Color Schemes
  ----------------------------------------------------------------------------------------
  use({ "rose-pine/neovim" })

  use({
    "shaunsingh/nord.nvim",
    setup = {
      "vim.g.nord_contrast = false",
      "vim.g.nord_borders = true",
      "vim.g.nord_disable_background = true",
      "vim.g.nord_italic = true",
    },
  })

  use({
    "navarasu/onedark.nvim",
    config = {
      "require('onedark-config')",
    },
  })

  use({
    "folke/tokyonight.nvim",
    branch = "main",
    setup = {
      "vim.g.tokyonight_style = 'night'",
      "vim.g.tokyonight_lualine_bold = 'true'",
      "vim.g.tokyonight_italic_functions = '1'",
      "vim.g.tokyonight_sidebars = { 'terminal' }",
    },
    -- config = "vim.cmd('colorscheme tokyonight')"
  })

  use({
    "adisen99/apprentice.nvim",
    requires = { "rktjmp/lush.nvim" },
    setup = {
      "vim.g.apprentice_contrast_dark = 'hard'",
    },
  })

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
    config = function() vim.cmd("colorscheme darkplus") end,
  })

  use({
    "EdenEast/nightfox.nvim",
    config = function() require("nightfox").setup({}) end,
  })

  use({
    "bluz71/vim-nightfly-guicolors",
  })

  use({
    "mcchrish/zenbones.nvim",
  })

  ----------------------------------------------------------------------------------------
  -- Better formatting, colors, auto pairs, etc
  ----------------------------------------------------------------------------------------

  use({
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    requires = "kyazdani42/nvim-web-devicons",
    setup = {
      vim.api.nvim_set_keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true }),
      vim.api.nvim_set_keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true }),
    },
    config = function()
      require("bufferline").setup({
        options = {
          separator_style = "thick",
        },
      })
    end,
  })

  use({ "windwp/nvim-autopairs", config = { "require('autopairs-config')" } })

  use({
    "numToStr/Comment.nvim",
    config = {
      "require('Comment').setup{ignore = '^$'}",
    },
  })

  -- This is now a treesitter module, it is NOT a standalone plugin, I will need to configure on
  -- treesitter
  use({ "p00f/nvim-ts-rainbow" })

  use({
    "norcalli/nvim-colorizer.lua",
    config = "require('colorizer').setup()",
  })

  use({
    "ntpeters/vim-better-whitespace",
    config = {
      vim.cmd(
        "let g:better_whitespace_filetypes_blacklist=['<filetype1>', '<filetype2>', '<etc>', 'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive', 'toggleterm']"
      ),
    },
  })

  use({ "lukas-reineke/indent-blankline.nvim", config = "require('blankline-config')" })

  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = "require('lualine-config')",
    after = "onedark.nvim", -- Fix here: https://github.com/nvim-lualine/lualine.nvim/issues/632
  })

  use({ "junegunn/goyo.vim" })

  ----------------------------------------------------------------------------------------
  -- Plugins that make this configuration a better IDE
  ----------------------------------------------------------------------------------------

  use("tpope/vim-fugitive")

  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = { "require('gitsigns-config')" },
    tag = "release", -- To use the latest release
  })

  -- See https://github.com/ellisonleao/glow.nvim/issues/82
  use({
    "ellisonleao/glow.nvim",
    branch = "main",
    config = {
      require("glow").setup({
        border = "rounded",
        width = 120,
      }),
    },
  })

  use({
    "davidgranstrom/nvim-markdown-preview",
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
    tag = "v2.*",
    config = "require('toggleterm-config')",
  })

  use({
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = { "require('telescope-config')", "require('user.telescope')" },
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

  use({
    "kylechui/nvim-surround",
    config = function() require("nvim-surround").setup({}) end,
  })

  use({
    "RRethy/vim-illuminate",
    config = function() require("illuminate").configure() end,
  })

  ----------------------------------------------------------------------------------------
  -- Language servers, code formatting, autocompletion
  ----------------------------------------------------------------------------------------
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ": TSUpdate",
    config = "require('treesitter-config')",
  })

  use({
    "hrsh7th/nvim-cmp",
    config = "require('cmp-config')",
  })

  use("neovim/nvim-lspconfig")

  use({
    "williamboman/nvim-lsp-installer",
    config = function()
      require("nvim-lsp-installer").setup({
        -- automatically detect which servers to install (based on which servers are set up via lspconfig)
        automatic_installation = true,
      })
    end,
  })

  use("hrsh7th/cmp-nvim-lsp")

  use("hrsh7th/cmp-buffer")

  use("hrsh7th/cmp-path")

  use("hrsh7th/cmp-cmdline")

  use("hrsh7th/cmp-vsnip")

  use("hrsh7th/cmp-nvim-lsp-signature-help")

  use("hrsh7th/cmp-nvim-lua")

  use({
    "hrsh7th/vim-vsnip",
    config = function() require("vim-vsnip-config") end,
  })

  use({ "onsails/lspkind-nvim" })

  use({ "jose-elias-alvarez/null-ls.nvim", config = "require('null-ls-config')" })

  use({
    "lewis6991/spellsitter.nvim",
    config = function() require("spellsitter").setup() end,
  })
  -------------------------------------------------------------------------------------------------

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then require("packer").sync() end
end)
