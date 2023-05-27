local buffer_option = vim.api.nvim_buf_set_option

local custom_lsp_attach = function(client, bufnr)
    --    See `:help formatexpr` for more information.
    buffer_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})")

    --Debug code
    -- To print capabilities present on buffer, execute this:
    -- :lua =vim.lsp.get_active_clients()[1].server_capabilities

    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signature_help"] =
        vim.lsp.with({ border = "rounded" }, vim.lsp.handlers.signature_help)

    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("document highlight", { clear = false }),
            pattern = { "*" },
            command = "lua vim.lsp.buf.format() vim.diagnostic.enable()",
        })
    end

    local illuminate_status_ok, illuminate = pcall(require, "illuminate")
    if illuminate_status_ok then illuminate.on_attach(client) end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_cmp_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

-- lua-language-server
require("lspconfig")["lua_ls"].setup({
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
                -- See https://github.com/LuaLS/lua-language-server/discussions/1688
                checkThirdParty = false,
            },
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "4",
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

require 'lspconfig'.marksman.setup {
    on_attach = custom_lsp_attach,
    capabilities = capabilities,
    filetypes = { "md", "markdown" },
    code_action = {
        enable = true,
    },
}
