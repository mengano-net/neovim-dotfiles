-- Exit if can't load module(s)
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    print("Couldn't require module 'cmp'.")
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    return
end

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
    Field = "ﴲ ",
}

local macchiato = require("catppuccin.palettes.macchiato")
local mocha = require("catppuccin.palettes.mocha")

-- Functions to implement autocomplete on the custom <Tab> and -- <S-Tab> mappings below
local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

---@cast cmp -?
-- See https://github.com/sumneko/lua-language-server/issues/1487
cmp.setup({
    -- disable completion in comments
    enabled = function()
        local context = require 'cmp.config.context'
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == 'c' then
            return true
        else
            return not context.in_treesitter_capture("comment")
                and not context.in_syntax_group("Comment")
        end
    end,
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    window = {
        completion = cmp.config.window.bordered({
            border = "shadow",
            winhighlight = "Normal:CmpWindowBackground,Floatborder:Pmenu,CursorLine:CmpWindowCursorLine,Search:None",
            -- col_offset = -3, -- to moveautocomplet pop window in the horizontal axis
        }),
        documentation = cmp.config.window.bordered({
            border = "shadow",
            winhighlight = "Normal:CmpWindowBackground,Floatborder:Pmenu,CursorLine:PmenuThumb,Search:None",
        }),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs( -4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                -- cmp.complete
                fallback()
            elseif has_words_before() then
                fallback()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable( -1) then
                luasnip.jump( -1)
            else
                fallback()
            end
        end, { "i", "s", }),
    }),
    sources = cmp.config.sources({
        { name = 'luasnip' }, -- For luasnip users.
        -- }, { -- If found in luasnip do not duplicate it for the others sources
        { name = "buffer",                 keyword_length = 4 },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
    }),
    ------------------------------------------------------------------------------------------
    --                     See this vedeo series on YouTube for details                     --
    --                     https://www.youtube.com/watch?v=8zENSGqOk8w                      --
    ------------------------------------------------------------------------------------------
    formatting = {
        fields = { "abbr", "kind", "menu" },
        -- fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            vim_item.kind = (cmp_icons[vim_item.kind] or "") .. " (" .. vim_item.kind .. ")"
            -- vim_item.kind = (cmp_icons[vim_item.kind] or "")
            vim_item.menu = " [" .. entry.source.name .. "]"
            return vim_item
        end
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    sorting = {
        comparators = {
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            cmp.config.compare.length,
            cmp.config.compare.locality,
        }
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
