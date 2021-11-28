vim.cmd [[

" LspDiagnostics highlights
" highlight LspDiagnosticsDefaultError guifg=BrightRed
" highlight LspDiagnosticsVirtualTextError guifg=Red
" highlight LspDiagnosticsUnderlineError guifg=Red
" highlight LspDiagnosticsVirtualTextWarning guifg=Yellow

" sign define DiagnosticSignError text=E texthl=DiagnosticSignError linehl= numhl=
" sign define DiagnosticSignWarn text=W texthl=DiagnosticSignWarn linehl= numhl=
" sign define DiagnosticSignInfo text=I texthl=DiagnosticSignInfo linehl= numhl=
" sign define DiagnosticSignHint text=H texthl=DiagnosticSignHint linehl= numhl=


autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

]]

vim.diagnostic.config{
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
 vim.lsp.diagnostic.on_publish_diagnostics, {
   -- Enable underline, use default values
   underline = true,
   -- Enable virtual text only on Warning or above, override spacing to 2
  signs = true,
   virtual_text = {
     spacing = 2,
     severity_limit = "Warning",
   },
 }
)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  -- local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

