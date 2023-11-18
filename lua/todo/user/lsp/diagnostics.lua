vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {})]])

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

-- vim.lsp.handlers["textDocument/publishDiagnostics"] =
-- vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--     --[[ virtual_text = {
--     spacing = 5,
--     severity_limit = "Warning",
--     prefix = " ", -- Could be '■' '●', '▎', 'x',
--   }, ]]
--     update_in_insert = false,
--     float = { scope = "line" }
-- })

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
