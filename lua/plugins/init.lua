-- Git clone and install packer if it's not installed already
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

-- Have packer use a float window instead of a vertical split
require("packer").init({
    display = {
        open_fn = function() return require("packer.util").float({ border = "rounded" }) end,
    },
})

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    ------------------------------------------------------------------------------------------
    --                                     Colorschemes                                     --
    ------------------------------------------------------------------------------------------
    use({ "rose-pine/neovim" })

    use({ "folke/tokyonight.nvim", branch = "main" })

    use({ "mengano-net/darkplus.nvim", branch = "develop" })

    use({
        "mcchrish/zenbones.nvim",
        requires = { "rktjmp/lush.nvim" },
    })

    use({
        "shaunsingh/nord.nvim",
        config = function()
            vim.g.nord_contrast = false
            vim.g.nord_borders = true
            vim.g.nord_disable_background = false
            vim.g.nord_italic = false
            vim.g.nord_uniform_diff_background = true
            vim.g.nord_bold = false
        end
    })

    use({ "catppuccin/nvim" })

    use { "cocopon/iceberg.vim" }

    ------------------------------------------------------------------------------------------
    --                          Plugins making Neovim a better IDE                          --
    ------------------------------------------------------------------------------------------

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
                "let g:better_whitespace_filetypes_blacklist=['diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'fugitive', 'toggleterm']"
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
        config = {
            function() vim.g.nvim_markdown_preview_theme = 'solarized-dark' end
        }
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
        requires = { "nvim-lua/popup.nvim", "nvim-telescope/telescope.nvim" }
    }

    ------------------------------------------------------------------------------------------
    --            Whichkey plugin calls MANY keymaps with functionality provided            --
    --         by other plugins. Do do NOT run until after all those other plugins          --
    --                            are installed and configured.                             --
    ------------------------------------------------------------------------------------------
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
        config = function() require("illuminate").configure()
            require('illuminate').configure({
                filetypes_denylist = { 'fugitive', 'NvimTree', 'help', 'gitcommit' },
            })
        end,
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

    use {
        "fgheng/winbar.nvim",
        config = function()
            require('winbar').setup({
                colors = {
                    path = '#7aa2f7',
                    file_name = '#c946fd',
                    symbols = '#c946fd',
                },
                enabled = true,
                exclude_filetype = {
                    'help',
                    'startify',
                    'dashboard',
                    'fugitive',
                    'gitcommit',
                    'packer',
                    'neogitstatus',
                    'NvimTree',
                    'Trouble',
                    'alpha',
                    'lir',
                    'Outline',
                    'spectre_panel',
                    'toggleterm',
                    'qf',
                    'glowpreview',
                },
            })
        end
    }

    use { "j-hui/fidget.nvim", config = function() require('fidget').setup() end }

    use { "karb94/neoscroll.nvim", config = function() require('neoscroll').setup() end }

    use {
        'jinh0/eyeliner.nvim',
        config = function()
            require 'eyeliner'.setup {
                highlight_on_key = true
            }
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

    use({ "saadparwaiz1/cmp_luasnip", requires = "L3MON4D3/LuaSnip" })

    use("hrsh7th/cmp-nvim-lsp-signature-help")

    use("hrsh7th/cmp-nvim-lua")

    use({
        "L3MON4D3/LuaSnip",
        -- tag = "v<CurrentMajor>.*",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    })

    use({ "rafamadriz/friendly-snippets", requires = "L3MON4D3/LuaSnip" })

    use({ "jose-elias-alvarez/null-ls.nvim", config = "require('null-ls-config')" })

    use({
        "lewis6991/spellsitter.nvim",
        config = function() require("spellsitter").setup() end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then require("packer").sync() end
end)
