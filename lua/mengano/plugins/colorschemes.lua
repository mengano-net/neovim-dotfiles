return {
    {
        "catppuccin/nvim",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato", -- latte, frappe, macchiato, mocha.
                styles = {
                    loops = {},
                    functions = {},
                    keywords = {},
                    strings = {},
                    numbers = {},
                    booleans = {},
                    properties = {},
                    operators = {},
                    conditionals = {},
                    types = {},
                    variables = {},
                },
                no_italic = true, -- Force no italic
                no_bold = true,   -- Force no bold
                highlight_overrides = {
                    -- To get Catppuccin's color palette run command: lua P(require("catppuccin.palettes").get_palette("macchiato"))
                    -- lualine_a_normal xxx gui=bold guifg=#1e2030 guibg=#8aadf4
                    -- lualine_b_normal xxx guifg=#8aadf4 guibg=#494d64
                    macchiato = function(macchiato)
                        return {
                            DiffAdd = { fg = macchiato.green, bg = "#24273A" },
                            DiffSignsAdd = { fg = macchiato.green, bg = "#24273A" },
                            DiffChange = { fg = "Pink", bg = "#24273A" },
                            GitSignsChange = { fg = "Pink", bg = "#24273A" },
                            DiffDelete = { fg = "#B55A67", bg = "#24273A" },
                            GitSignsDelete = { fg = "#B55A67", bg = "#24273A" },
                            IlluminatedWordText = { bg = "#494d64", underline = false },
                            CmpWindowBackground = { bg = macchiato.base },
                            CmpWindowCursorLine = { fg = macchiato.lavender, bg = macchiato.surface0 },
                            CmpItemAbbrMatch = { fg = macchiato.red, bg = macchiato.base },
                            CmpItemAbbrMatchFuzzy = { fg = macchiato.yellow, bg = macchiato.overlay0 },
                            CmpItemMenu = { fg = macchiato.maroon },
                        }
                    end
                },
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    treesitter = true,
                    -- For more plugins integrations see (https://github.com/catppuccin/nvim#integrations)
                },
            })
            vim.cmd([[colorscheme catppuccin-macchiato]])
        end,
    },
    { "folke/tokyonight.nvim" },
}
