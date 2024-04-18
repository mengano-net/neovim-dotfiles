return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("LspAttach", { clear = false }),
                callback = function(args)
                    -- opts for buffer's local mappings.
                    local opts = { buffer = args.buf }
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    vim.lsp.handlers["textDocument/hover"] =
                        vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

                    vim.lsp.handlers["textDocument/signature_help"] =
                        vim.lsp.with({ border = "rounded" }, vim.lsp.handlers.signature_help)

                    -- format buffer when Lsp attaches
                    if client.server_capabilities.documentFormattingProvider then
                        vim.lsp.buf.format()
                    end
                end,
            })

            -- To print capabilities present on buffer, execute this:
            -- :lua =vim.lsp.get_active_clients()[1].server_capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            if cmp_nvim_lsp then
                capabilities = vim.tbl_deep_extend(
                    "force",
                    capabilities,
                    require("cmp_nvim_lsp").default_capabilities()
                )
            end

            -- Diagnostic Signs
            vim.diagnostic.config({
                virtual_text = false,
                signs = true,
                underline = true,
                update_in_insert = true,
                float = {
                    border = "rounded",
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
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            -- LS configuration for the different languages
            lspconfig["lua_ls"].setup({
                capabilities = capabilities,
                flags = { debounce_text_changes = 150 },
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                            neededFileStatus = { ["codestyle-check"] = "Any" },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
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
                capabilities = capabilities,
            })

            -- bash language server
            lspconfig["bashls"].setup({
                capabilities = capabilities,
                flags = {
                    debounce_text_changes = 150,
                },
                filetypes = { "sh", "zsh" },
            })

            -- yaml LSP
            lspconfig["yamlls"].setup({
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
                capabilities = capabilities,
                code_action = { enable = true },
            })
        end,
    },
    {
        "aznhe21/actions-preview.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("actions-preview").setup({
                telescope = require("telescope.themes").get_ivy(),
                vim.keymap.set(
                    { "n" },
                    "<leader>ga",
                    '<cmd>lua require("actions-preview").code_actions()<cr>',
                    { desc = "Code ( a )ctions" }
                ),
            })
        end,
    },
}
