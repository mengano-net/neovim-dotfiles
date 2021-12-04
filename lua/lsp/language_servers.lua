local custom_lsp_attach = function(client)

  -- See `:help nvim_buf_set_keymap()` for more information
  local mapping_opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', mapping_opts)
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_buf_set_keymap(0, 'n', 'gD', '<cmd> lua vim.lsp.buf.definition()<CR>', mapping_opts)
    vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd> lua vim.lsp.buf.declaration()<CR>', mapping_opts)
  end
  -- vim.api.nvim_buf_set_keymap(0, 'n', 'gD', '<cmd> lua')

  -- buf_set_keymap('n', '<leader>wa', ':lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<cr>', opts)
  -- buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- -- buf_set_keymap('n', '<leader>p', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- Use LSP as the handler for omnifunc.
  --    See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Use LSP as the handler for formatexpr.
  --    See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

end

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.cssls.setup {
  -- cmd = { '/usr/bin/css-language-server', '--stdio' },
  -- macos
  cmd = { '/usr/local/bin/css-language-server', '--stdio' },
  -- /usr/local/bin/css-language-server
  capabilities = capabilities,
  on_attach = custom_lsp_attach,
}

require'lspconfig'.html.setup {
  cmd = { '/usr/bin/html-languageserver', '--stdio' },
  capabilities = capabilities,
  -- vim.lsp.diagnostic.show_line_diagnostics(),
  on_attach = custom_lsp_attach,
}

require'lspconfig'.pyright.setup {
  -- cmd = { '/usr/bin/pyright', '--stdio' },
  -- macos has this path, I need to work on this
  cmd = { '/usr/local/bin/pyright', '--stdio' },
  capabilities = capabilities,
  on_attach = custom_lsp_attach,
}

require'lspconfig'.bashls.setup{
  cmd = { '/usr/local/bin/bash-language-server', 'start' },
  filetypes = { 'sh', 'zsh' },
  capabilities = capabilities,
  on_attach = custom_lsp_attach,
}

require'lspconfig'.yamlls.setup{
  -- cmd = { '/usr/local/bin/yaml-language-server' },
  debounce_text_changes = 150,
  filetypes = { 'yaml', 'yml' },
  settings = {
    yaml = {
      hover = true,
      format = {
        enable = true,
        singleQuote = true,
      },
      completion = true,
      validate = true,
      customTags = {
        '!Ref',
        '!ImportValue',
        '!Sub',
        '!GetAtt',
        '!GetAZs',
        '!Join sequence',
        '!Equals sequence',
        '!FindInMap sequence',
        '!Select sequence',
        '!Split sequence',
      },
    },
  },
}

-- lua-language-server
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
USER = vim.fn.expand('$USER')

local sumneko_root_path = ""
local sumneko_binary = ""

if vim.fn.has("mac") == 1 then
  sumneko_root_path = "/Users/" .. USER .. "/.local/lua-language-server"
  sumneko_binary = "/Users/" .. USER .. "/.local/lua-language-server/bin/macOS/lua-language-server"
elseif vim.fn.has("unix") == 1 then
  sumneko_root_path = "/home/" .. USER .. "/.local/lua-language-server"
  sumneko_binary = "/home/" .. USER .. "/.local/lua-language-server/bin/Linux/lua-language-server"
else
  print("Unsupported system for sumneko")
end

require'lspconfig'.sumneko_lua.setup {
  on_attach = custom_lsp_attach,
  debounce_text_changes = 150,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';')
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' }
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          [vim.fn.expand('~/.config.nvim/lua')] = true,
        }
      }
    }
  }
}
