----------------------------------------------------------------------
--                   Automatically install packer                   --
----------------------------------------------------------------------

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git', 'clone', '--depth', '1',
      'https://github.com/wbthomason/packer.nvim', install_path
    })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Have packer use a pop-up window
require("packer").init({
  display = {
    open_fn = function() return require("packer.util").float({ border = "rounded" }) end,
  },
})

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  ----------------------------------------------------------------------
  --                           Color Scheme                           --
  ----------------------------------------------------------------------
  use({ "rose-pine/neovim" })

  use({ "folke/tokyonight.nvim", branch = "main" })

  use({ "mengano-net/darkplus.nvim" })

  use({
    "mcchrish/zenbones.nvim",
    requires = { "rktjmp/lush.nvim" },
  })

  use({ "shaunsingh/nord.nvim" })

  use({ "catppuccin/nvim" })

  use({
    "mengano-net/cubandusk.nvim",
    branch = "palette",
  })

  ----------------------------------------------------------------------
  --            Better formatting, colors, auto pairs, etc            --
  ----------------------------------------------------------------------

  --[[ use({
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
          sort_by = "insert_at_end",
          diagnostics = "nvim_lsp",
        },
      })
    end,
  }) ]]

  use({ "windwp/nvim-autopairs", config = { "require('autopairs-config')" } })

  use({
    "numToStr/Comment.nvim",
    config = {
      "require('Comment').setup{ignore = '^$'}",
    },
  })

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

  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        buftype_exclude = { "terminal", "help", "nofile", "NvimTree" },
        filetype_exclude = { "packer", "help", "NvimTree" },
        show_current_context_start = true,
        show_end_of_line = true,
        show_icons = {
          git = 1,
        },
      })
    end,
  })

  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = "require('lualine-config')",
  })

  ----------------------------------------------------------------------
  --        Plugins that make this configuration a better IDE         --
  ----------------------------------------------------------------------
  use("tpope/vim-fugitive")

  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = {
            hl = "GitSignsAdd",
            text = "▎",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
          },
          change = {
            hl = "GitSignsChange",
            text = "▎",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
          },
        },
        attach_to_untracked = true,
      })
    end,
    requires = { "nvim-lua/plenary.nvim" },
  })

  -- See https://github.com/ellisonleao/glow.nvim/issues/82
  use({
    "ellisonleao/glow.nvim",
    branch = "main",
    config = function()
      require("glow").setup({
        border = "rounded",
        width = 120,
      })
    end,
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
    config = { "require('telescope-config')", "require('user.telescope-extensions')" },
  })

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    requires = { "nvim-telescope/telescope.nvim" },
    run = 'make'
  }

  use {
    "jvgrootveld/telescope-zoxide",
    requires = { "nvim-lua/popup.nvim" }
  }

  -- This plugin has MANY key maps configured to call several of the plugins above, do NOT
  -- install it until the previous plugins are also installed and configured FIRST
  -- Such plugins are(not exhaustive): telescope, gitsigns, nvimTree, etc.
  use({
    "folke/which-key.nvim",
    config = function()
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

  use {
    's1n7ax/nvim-comment-frame',
    requires = { 'nvim-treesitter' },
    config = function()
      require('nvim-comment-frame').setup({
        disable_default_keymap = true,
        frame_width = 90,
        line_wrap_len = 80,
        languages = {
          python = {
            frame_width = 61,
            line_wrap_len = 52,
            start_str = '# --',
            end_str = '-- #',
          },
        }
      })
    end
  }

  ----------------------------------------------------------------------------------------
  -- Language servers, code formatting, autocompletion
  ----------------------------------------------------------------------------------------
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ": TSUpdate",
    config = "require('treesitter-config')",
    -- This is now a treesitter module, it is NOT a standalone plugin
    requires = "p00f/nvim-ts-rainbow",
  })

  -- This is now a treesitter module, it is NOT a standalone plugin
  use({
    "nvim-treesitter/playground",
    requires = "nvim-treesitter/nvim-treesitter",
  })


  use({
    "hrsh7th/nvim-cmp",
    config = "require('cmp-config')",
  })

  use({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    config = {
      require("mason").setup(),
      require("mason-lspconfig").setup({
        ensure_installed = { "sumneko_lua", "bashls", "yamlls", "pyright" },
      })
    }
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

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then require("packer").sync() end
end)
