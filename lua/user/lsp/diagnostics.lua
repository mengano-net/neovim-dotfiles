-- Diagnostics and their representation
-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

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
        severity_sort = false,
        style = "minimal",
        source = "always",
    },
    severity_sort = false,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] =
vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    --[[ virtual_text = {
    spacing = 5,
    severity_limit = "Warning",
    prefix = " ", -- Could be '■' '●', '▎', 'x',
  }, ]]
    update_in_insert = false,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
