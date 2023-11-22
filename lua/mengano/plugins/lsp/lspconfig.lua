return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")
        -- local keymap = vim.keymap

        local on_attach = function(client, bufnr)
            --Debug code
            -- To print capabilities present on buffer, execute this:
            -- :lua =vim.lsp.get_active_clients()[1].server_capabilities

            vim.lsp.handlers["textDocument/hover"] =
                vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
            vim.lsp.handlers["textDocument/signature_help"] =
                vim.lsp.with({ border = "rounded" }, vim.lsp.handlers.signature_help)

            if client.server_capabilities.documentFormattingProvider then
                vim.api.nvim_create_autocmd("LspAttach", {
                    group = vim.api.nvim_create_augroup("document highlight", { clear = false }),
                    pattern = { "*" },
                    command = "lua vim.lsp.buf.format() vim.diagnostic.enable()",
                })
            end
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        if cmp_nvim_lsp then
            capabilities = cmp_nvim_lsp.default_capabilities()
        end

        -- Diagnostic Signs
        vim.diagnostic.config({
            virtual_text = false,
            signs = true,
            underline = true,
            update_in_insert = true,
            float = {
                border = "single",
                header = "",
                focusable = false,
                prefix = "",
                scope = "cursor",
                severity_sort = true,
                source = "if_many",
                spacing = 3,
            },
            severity_sort = true,
        })
        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        -- LS configuration for the different languages
        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            flags = { debounce_text_changes = 150 },
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognze the `vim` global
                        globals = { "vim" },
                        -- Lua LSP to check code styles too, like indentation
                        -- best practices, etc
                        neededFileStatus = { ["codestyle-check"] = "Any" },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                        -- See
                        -- https://github.com/LuaLS/lua-language-server/discussions/1688
                        checkThirdParty = false,
                    },
                    format = {
                        enable = true,
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = "4",
                        },
                    },
                    telemetry = { enable = false },
                },
            },
        })

        lspconfig["pyright"].setup({
            filetypes = { "python" },
            on_attach = on_attach,
            capabilities = capabilities,
        })

        -- bash language server
        lspconfig["bashls"].setup({
            -- cmd = { "/usr/bin/bash-language-server", "start" },
            -- cmd == { "~/.local/share/nvim/lsp_servers/bash", "start" },
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
            filetypes = { "sh", "zsh" },
        })

        -- yaml LSP
        lspconfig["yamlls"].setup({
            -- cmd = { yamlls_binary, "--stdio" },
            on_attach = on_attach,
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

        -- marksman LSP
        lspconfig["marksman"].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            code_action = { enable = true },
        })
    end,
}
