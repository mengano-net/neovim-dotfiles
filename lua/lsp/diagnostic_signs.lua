vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

vim.diagnostic.config{
  virtual_text = false,
  signs = false,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- signs = true,
    signs = {
      severity_limit = 'Hint',
    },
    -- virtual_text = {
    --   spacing = 5,
    --   severity_limit = "Hint",
    --   prefix = ' ', -- Could be '■' '●', '▎', 'x',
    -- },
  }
)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
