return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            },
            max_concurrent_installers = 10,
        })

        mason_lspconfig.setup({
            ensure_installed = {
                "lua_ls", "bashls", "yamlls", "pyright", "marksman"
            },
            automatic_installation = true,
        })
    end,
}
