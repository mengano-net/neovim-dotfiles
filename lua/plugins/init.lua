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
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- return require('packer').startup(function()
return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = "require('lualine-config')",
	})
	use({
		"akinsho/bufferline.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = { "require('bufferline-config')" },
	})
	use({ "windwp/nvim-autopairs", config = { "require('autopairs-config')" } })
	use({ "p00f/nvim-ts-rainbow" })
	use("tpope/vim-fugitive")
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = { "require('gitsigns-config')" },
		-- tag = 'release' -- To use the latest release
	})
	use({ "numToStr/Comment.nvim", config = "require('comment-config')" })
	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = { "require('telescope-config')", "require('telescope-extensions')" },
	})
	use({ "rcarriga/nvim-notify", config = "require('notify-extensions')" })
	use({ "norcalli/nvim-colorizer.lua", config = "require('colorizer-config')" })
	use("ntpeters/vim-better-whitespace")
	use({ "lukas-reineke/indent-blankline.nvim", config = "require('blankline-config')" })
	use({ "akinsho/toggleterm.nvim", config = "require('toggleterm-config')" })
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
		config = {
			-- function() require'nvim-tree'.setup {} end,
			"require('nvimtree-config')",
		},
	})
	use({
		"folke/which-key.nvim",
		config = function()
			-- require("which-key").setup {}
			require("whichkey-config")
		end,
	})
	use({
		"ellisonleao/glow.nvim",
		setup = { "vim.g.glow_border = 'rounded'" },
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = "require('treesitter-config')",
	})

	-- LSP
	use("neovim/nvim-lspconfig")
	use({ "onsails/lspkind-nvim", config = "require('lspkind-config')" })
	--[[ I'm trying to retire LSPSaga, most of its functions are implemented builtin
  use { 'tami5/lspsaga.nvim', config = "require('lspsaga-config')" } ]]
	use({ "tami5/lspsaga.nvim" })
	use({ "williamboman/nvim-lsp-installer", config = "require('nvim-lsp-installer')" })
	use({ "jose-elias-alvarez/null-ls.nvim", config = "require('null-ls-config')" })

	-- cmp
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")

	-- colorschemes
	use({ "rose-pine/neovim" })
	use("shaunsingh/nord.nvim")
	use({ "navarasu/onedark.nvim", setup = "vim.g.onedark_style = 'dark'" })
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
	use({ "lunarvim/darkplus.nvim", config = "vim.cmd('colorscheme darkplus')" })

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
