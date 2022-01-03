-- Exit if can't load module(s)
local status_ok, nvim_lsp = pcall(require, "lspconfig")
if not status_ok then
  return
end

vim.opt.completeopt = "menuone,noinsert,noselect"
local buffer_map = vim.api.nvim_buf_set_keymap
local buffer_option = vim.api.nvim_buf_set_option
local map_opts = { noremap=true, silent=true }

local custom_lsp_attach = function(client,bufnr)

  -- Use LSP as the handler for omnifunc.
  --    See `:help omnifunc` and `:help ins-completion` for more information.
  buffer_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Use LSP as the handler for formatexpr.
  --    See `:help formatexpr` for more information.
  buffer_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

  -- See `:help nvim_buf_set_keymap()` for more information
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', map_opts)
  buffer_map(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', map_opts)
  buffer_map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', map_opts)
  buffer_map(bufnr, 'n', 'gj', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', map_opts)
  buffer_map(bufnr, 'n', 'gk', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', map_opts)

  if client.resolved_capabilities.textDocument_declaration then
    buffer_map(bufnr, 'n', 'gd', '<cmd> lua vim.lsp.buf.declaration()<CR>', map_opts)
  end

  if client.resolved_capabilities.document_formatting then
    buffer_map(bufnr, 'n', 'gq', '<cmd>lua vim.lsp.buf.formatting()<CR>', map_opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buffer_map(bufnr, 'n', 'gq', '<cmd>lua vim.lsp.buf.formatting()<CR>', map_opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end

  --Debug code
  --[[
  if client.resolved_capabilities.code_action then
    print("codeAction present")
  else
    print("No codeAction")
  end
  ]]


  -- Format on save BufWritePre to run lua formatting, conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end
end

-- Setup capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

nvim_lsp.pylsp.setup {
  cmd = { "pylsp" },
  filetypes = { "python" },
  on_attach = custom_lsp_attach,
  capabilities = capabilities,
}

-- bash language server
nvim_lsp.bashls.setup{
  cmd = {"/usr/bin/bash-language-server", "start"},
  on_attach = custom_lsp_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  filetypes = { 'sh', 'zsh' },
}

--yaml language server
local yamlls_binary = ''
if vim.fn.has('mac') == 1 then
  yamlls_binary = '/usr/local/bin/yaml-language-server'
elseif vim.fn.has("unix") == 1 then
  yamlls_binary = '/usr/bin/yaml-language-server'
end

nvim_lsp.yamlls.setup{
  cmd = {yamlls_binary, "--stdio"},
  on_attach = custom_lsp_attach,
  capabilities = capabilities,
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
  sumneko_binary = "/home/" .. USER .. "/.local/lua-language-server/bin/lua-language-server"
else
  print("Unsupported system for sumneko")
end

nvim_lsp.sumneko_lua.setup {
  on_attach = custom_lsp_attach,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  -- cmd = {"/home/ec2-user/github-repos/lua-language-server/bin/Linux/lua-language-server", "-E", "/home/ec2-user/github-repos/lua-language-server/" .. "main.lua"},
  flags = {debounce_text_changes = 150},
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

-- vim.lsp.set_log_level('debug')
