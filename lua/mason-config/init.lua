-- skip if module(s) isn't loaded
local status_ok, _ = pcall(require, "mason")
if not status_ok then return end

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "sumneko_lua", "bashls", "yamlls" },
})
