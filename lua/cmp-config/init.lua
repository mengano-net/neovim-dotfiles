-- Exit if can't load module(s)
local cmp_status_ok, cmp = pcall(require, "cmp")
local entry              = require("cmp.entry")
if not cmp_status_ok then
    print("Couldn't require module 'cmp'.")
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

require("luasnip/loaders/from_vscode").lazy_load()

local cmp_icons = {
    Text = " ",
    Method = " ",
    -- Function = "ﬦ",
    Function = "ƒ",
    Constructor = " ",
    Variable = " ",
    Class = " ",
    Interface = "ﰮ",
    Module = " ",
    Property = "",
    Unit = "",
    Value = " ",
    Enum = "了",
    Keyword = "",
    Color = " ",
    File = " ",
    Folder = " ",
    -- Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Reference = " ",
    Snippet = " ",
    Struct = " ",
    Event = "",
}

local macchiato = require("catppuccin.palettes.macchiato")
local mocha = require("catppuccin.palettes.mocha")

-- Functions to implement autocomplete on the custom <Tab> and -- <S-Tab> mappings below
local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

---@cast cmp -?
-- See https://github.com/sumneko/lua-language-server/issues/1487
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },

    -- Catppuccin's macchiato color palette, for custom color palettes for cmp window
    -- You get it by running this command: lua P(require("catppuccin.palettes").get_palette("macchiato"))
    -- Here is Catppuccin's Mocha palette:
    --[[ base = "#1E1E2E",
      blue = "#89B4FA",
      crust = "#11111B",
      flamingo = "#F2CDCD",
      green = "#A6E3A1",
      lavender = "#B4BEFE",
      mantle = "#181825",
      maroon = "#EBA0AC",
      mauve = "#CBA6F7",
      overlay0 = "#6C7086",
      overlay1 = "#7F849C",
      overlay2 = "#9399B2",
      peach = "#FAB387",
      pink = "#F5C2E7",
      red = "#F38BA8",
      rosewater = "#F5E0DC",
      sapphire = "#74C7EC",
      sky = "#89DCEB",
      subtext0 = "#A6ADC8",
      subtext1 = "#BAC2DE",
      surface0 = "#313244",
      surface1 = "#45475A",
      surface2 = "#585B70",
      teal = "#94E2D5",
      text = "#CDD6F4",
      yellow = "#F9E2AF" ]]
    vim.api.nvim_set_hl(0, "CmpWindowBackground", { bg = mocha.base }),
    vim.api.nvim_set_hl(0, "CmpWindowCursorLine", { fg = macchiato.lavender, bg = mocha.surface0 }),
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = macchiato.red, bg = macchiato.base }),
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = macchiato.yellow, bg = mocha.overlay0 }),
    vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = macchiato.lavender }),

    window = {
        completion = cmp.config.window.bordered({
            border = "shadow",
            winhighlight = "Normal:CmpWindowBackground,Floatborder:Pmenu,CursorLine:CmpWindowCursorLine,Search:None",
        }),
        documentation = cmp.config.window.bordered({
            border = "shadow",
            winhighlight = "Normal:CmpWindowBackground,Floatborder:Pmenu,CursorLine:PmenuThumb,Search:None",
        }),
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expendable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                -- cmp.complete
                fallback()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s", }),
    }),

    sources = cmp.config.sources({
        { name = 'luasnip' }, -- For luasnip users.
        -- }, { -- If found in luasnip do not duplicate it for the others sources
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
        { name = "cmdline" },
    }),

    ------------------------------------------------------------------------------------------
    --                     See this vedeo series on YouTube for details                     --
    --                     https://www.youtube.com/watch?v=8zENSGqOk8w                      --
    ------------------------------------------------------------------------------------------
    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)
            local source = entry.source.name
            local kind = vim_item.kind
            kind = (cmp_icons[kind] or "") .. " (" .. kind .. ")"
            vim_item.menu = " [" .. source .. "]"
            return vim_item
        end
    },

    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
        { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = "buffer" },
    }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})
