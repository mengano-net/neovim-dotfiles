-- local colorscheme = "tokyonight"
local colorscheme = "catppuccin"
-- local colorscheme = "cubandusk"

local status_ok, _ = pcall(require, colorscheme)
if not status_ok then
    print("colorscheme not found: " .. colorscheme)
    return
end

if colorscheme == "tokyonight" then
    require("tokyonight").setup({
        style = "night",
        styles = {
            comments = { italic = false },
            keywords = { italic = false },
            sidebars = { "terminal" },
            lualine_bold = false,
        },
    })
end

if colorscheme == "rose-pine" then
    require('rose-pine').setup({
        dark_variant = 'moon',
        border = 'highlight_hi',
        disable_italics = true,
        --[[ highlight_groups = {
      ColorColumn = { bg = 'rose' }
    }, ]]
    })
end

if colorscheme == "catppuccin" then
    -- vim.api.nvim_set_hl(0, lualine_b_diff_removed, {})
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
        highlight_overrides = {
            macchiato = function(macchiato)
                return {
                    DiffAdd = { fg = macchiato.green, bg = "#24273A" },
                    DiffSignsAdd = { fg = macchiato.green, bg = "#24273A" },
                    DiffChange = { fg = "Pink", bg = "#24273A" },
                    GitSignsChange = { fg = "Pink", bg = "#24273A" },
                    DiffDelete = { fg = "#D0312D", bg = "#24273A" },
                    GitSignsDelete = { fg = "#D0312D", bg = "#24273A" },
                    IlluminatedWordText = { bg = "#494d64", underline = false }
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
end

pcall(vim.cmd, "colorscheme " .. colorscheme)
