-- Exit if can't load module(s)
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    print("Couldn't require module 'cmp'.")
    return
end

local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status_ok then
    print("Couldn't require module 'cmp_nvim_lsp'.")
    return
end

local status_ok, lspkind = pcall(require, "lspkind")
if not status_ok then
    print("Couldn't require module 'lspkind'.")
    return
end

lspkind.init({
    mode = "symbol_text",
    symbol_map = {
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
    },
})

local buffer_map = vim.api.nvim_buf_set_keymap
local buffer_option = vim.api.nvim_buf_set_option
local map_opts = { noremap = true, silent = true }
local macchiato = require("catppuccin.palettes.macchiato")
local mocha = require("catppuccin.palettes.mocha")

-- Functions to implement autocomplete on the custom <Tab> and -- <S-Tab> mappings below
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local custom_lsp_attach = function(client, bufnr)
    --    See `:help formatexpr` for more information.
    buffer_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

    -- Handlers
    --Debug code
    -- To print capabilities present on buffer, execute this:
    -- :lua =vim.lsp.get_active_clients()[1].server_capabilities

    vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signature_help"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

    buffer_map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
    buffer_map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
    buffer_map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", map_opts)

    if client.server_capabilities.textDocument_declaration then
        buffer_map(bufnr, "n", "gD", "<cmd> lua vim.lsp.buf.declaration()<CR>", map_opts)
    end

    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("document highlight", { clear = false }),
            pattern = { "*" },
            command = "lua vim.lsp.buf.format() vim.diagnostic.enable()",
        })
    end

    local illuminate_status_ok, illuminate = pcall(require, "illuminate")
    if not illuminate_status_ok then return end
    illuminate.on_attach(client)
end

---@cast cmp -?
-- See https://github.com/sumneko/lua-language-server/issues/1487
cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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
    vim.api.nvim_set_hl(0, "CmpWindowCursorLine", { fg = macchiato.peach, bg = macchiato.overlay0 }),
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = macchiato.red, bg = macchiato.base }),
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = macchiato.yellow, bg = macchiato.overlay0 }),

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
        -- ['<C-e>'] = cmp.mapping.abort(),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"]() == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),
    }),

    sources = cmp.config.sources({
        { name = "vsnip" }, -- For vsnip users.
        { name = "buffer" },
        { name = "nvim_lsp" },
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
        { name = "path" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lua" },
    }),

    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = {
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
            },
        }),
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

-- Setup lspconfig.
local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- lua-language-server
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)

local sumneko_root_path = ""
local sumneko_binary = ""
USER = vim.fn.expand("$USER")

if vim.fn.has("mac") == 1 then
    sumneko_root_path = "/Users/"
        .. USER
        .. "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server"
    sumneko_binary = "/Users/"
        .. USER
        .. "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server"
elseif vim.fn.has("unix") == 1 then
    sumneko_root_path = "/home/" .. USER .. "/.local/lua-language-server"
    sumneko_binary = "/home/" .. USER .. "/.local/lua-language-server/bin/lua-language-server"
else
    print("Can't find lua-language-server binary.")
end

-- lua-language-server
require("lspconfig")["sumneko_lua"].setup({
    -- cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
    capabilities = capabilities,
    on_attach = custom_lsp_attach,
    flags = { debounce_text_changes = 150 },
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = vim.split(package.path, ";"),
            },
            diagnostics = {
                globals = { "vim" }, -- Get the language server to recognze the `vim` global
                -- This sets up lua-language-server to check code styles too, like indentation best practices, etc
                --[[ neededFileStatus = {
          ["codestyle-check"] = "Any",
        }, ]]
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                },
            },
            telemetry = { enable = false }, -- Do not send randomized but unique telemetry data
        },
    },
})

-- Python
--[[ local pylsp_root_binary = ""
if vim.fn.has("mac") == 1 then
  pylsp_root_binary = "/Users/" .. USER .. "/.local/share/nvim/lsp_servers/pylsp/venv/bin/pylsp"
elseif vim.fn.has("unix") == 1 then
else
  print("Unsupported system for pylsp")
end

require("lspconfig")["pylsp"].setup({
  -- cmd = { "pylsp" },
  cmd = { pylsp_root_binary },
  filetypes = { "python" },
  on_attach = custom_lsp_attach,
  capabilities = capabilities,
}) ]]
require("lspconfig")["pyright"].setup({
    filetypes = { "python" },
    on_attach = custom_lsp_attach,
    capabilities = capabilities,
})

-- bash language server
require("lspconfig")["bashls"].setup({
    -- cmd = { "/usr/bin/bash-language-server", "start" },
    -- cmd == { "~/.local/share/nvim/lsp_servers/bash", "start" },
    on_attach = custom_lsp_attach,
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 150,
    },
    filetypes = { "sh", "zsh" },
})

--yaml language server
--[[ local yamlls_binary = ""
if vim.fn.has("mac") == 1 then
  yamlls_binary = "/usr/local/bin/yaml-language-server"
elseif vim.fn.has("unix") == 1 then
  yamlls_binary = "/usr/bin/yaml-language-server"
end ]]

require("lspconfig")["yamlls"].setup({
    -- cmd = { yamlls_binary, "--stdio" },
    on_attach = custom_lsp_attach,
    capabilities = capabilities,
    debounce_text_changes = 150,
    filetypes = { "yaml", "yml" },
    settings = {
        yaml = {
            hover = true,
            format = {
                enable = true,
                singleQuote = true,
            },
            completion = true,
            validate = true,
            SchemeStore = { enable = true },
            customTags = {
                "!fn",
                "!And",
                "!If",
                "!Not",
                "!Equals",
                "!Or",
                "!Base64",
                "!Cidr",
                "!Ref",
                "!ImportValue",
                "!Sub sequence",
                "!Sub scalar",
                "!GetAtt",
                "!GetAZs",
                "!Join sequence",
                "!Equals sequence",
                "!FindInMap sequence",
                "!Select sequence",
                "!Split sequence",
            },
        },
    },
})
