-- Exit if can't load module(s)
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  print("Couldn't require module 'cmp'.")
  return
end

local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status_ok then
  print("Couldn't require module 'cmp_nvim_lsp'.")
  return
end

local status_ok, lspkind = pcall(require, "lspkind")
if not status_ok then
  print("Couldn't require module 'lspkind'.")
  return
end

lspkind.init({
  mode = "symbol_text",
  symbol_map = {
    Text = " ",
    Method = " ",
    -- Function = "ﬦ",
    Function = "ƒ",
    Constructor = " ",
    Variable = " ",
    Class = " ",
    Interface = "ﰮ",
    Module = " ",
    Property = "",
    Unit = "",
    Value = " ",
    Enum = "了",
    Keyword = "",
    Color = " ",
    File = " ",
    Folder = " ",
    -- Folder = " ",
    EnumMember = " ",
    Constant = " ",
    Reference = " ",
    Snippet = " ",
    Struct = " ",
    Event = "",
  },
})

vim.g.completeopt = "menu,menuone,preview,noselect,noinsert"
local buffer_map = vim.api.nvim_buf_set_keymap
local buffer_option = vim.api.nvim_buf_set_option
local map_opts = { noremap = true, silent = true }

-- Functions to implement autocomplete on the custom <Tab> and -- <S-Tab> mappings below
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0
      and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local custom_lsp_attach = function(client, bufnr)
  -- omnifunc is INCOMPATIBLE with nvim-cmp
  --[[ Use LSP as the handler for omnifunc.
     See `:help omnifunc` and `:help ins-completion` for more information.
  buffer_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc") ]]

  -- Use LSP as the handler for formatexpr.
  --    See `:help formatexpr` for more information.
  buffer_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Handlers
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signature_help"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

  -- buffer_map(bufnr, 'n', 'k', '<cmd>lua vim.lsp.buf.signature_help()<cr>', map_opts)
  --[[ moved to whichkey
  buffer_map(bufnr, 'n', 'gj', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', map_opts)
  buffer_map(bufnr, 'n', 'gk', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', map_opts) ]]
  buffer_map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
  buffer_map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
  buffer_map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", map_opts)

  -- See https://neovim.io/doc/user/lsp.html
  if client.server_capabilities.textDocument_declaration then
    buffer_map(bufnr, "n", "gD", "<cmd> lua vim.lsp.buf.declaration()<CR>", map_opts)
  end

  -- highlight words under cursor
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = vim.api.nvim_create_augroup("document highlight", { clear = false }),
      pattern = { "*.yaml", "*.yml", "*.lua", "*.py" },
      command = "lua vim.lsp.buf.document_highlight()",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = vim.api.nvim_create_augroup("document highlight", { clear = false }),
      pattern = { "*.yaml", "*.yml", "*.lua", "*.py" },
      command = "lua vim.lsp.buf.clear_references()",
    })
  end

  --Debug code
  -- To print capabilities present on buffer, execute this:
  -- :lua =vim.lsp.get_active_clients()[1].server_capabilities

  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("document highlight", { clear = false }),
      pattern = { "*" },
      -- command = "lua vim.lsp.buf.formatting()",
      command = "lua vim.lsp.buf.format()",
    })
  end
end

-- Diagnostics and their representation
-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

vim.diagnostic.config({
  virtual_text = false,
  signs = false,
  underline = true,
  update_in_insert = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
  severity_sort = true,
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  signs = {
    severity_limit = "Hint",
  },
  -- virtual_text = {
  --   spacing = 5,
  --   severity_limit = "Hint",
  --   prefix = ' ', -- Could be '■' '●', '▎', 'x',
  -- },
  update_in_insert = false,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-Space>"] = cmp.mapping.complete(),
    -- ['<C-e>'] = cmp.mapping.abort(),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"]() == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources({
    { name = "vsnip" }, -- For vsnip users.
    { name = "buffer" },
    { name = "nvim_lsp" },
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    { name = "path" },
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lua" },
  }),

  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = lspkind.cmp_format({
      mode = "symbol_text",
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
      },
    }),
  },

  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = "buffer" },
  }),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

-- Setup lspconfig.
local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- lua-language-server
-- https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)

local sumneko_root_path = ""
local sumneko_binary = ""
USER = vim.fn.expand("$USER")

if vim.fn.has("mac") == 1 then
  sumneko_root_path = "/Users/"
      .. USER
      .. "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server"
  sumneko_binary = "/Users/"
      .. USER
      .. "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server"
elseif vim.fn.has("unix") == 1 then
  sumneko_root_path = "/home/" .. USER .. "/.local/lua-language-server"
  sumneko_binary = "/home/" .. USER .. "/.local/lua-language-server/bin/lua-language-server"
else
  print("Can't find lua-language-server binary.")
end

-- lua-language-server
require("lspconfig")["sumneko_lua"].setup({
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
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
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        },
      },
      telemetry = { enable = false }, -- Do not send randomized but unique telemetry data
    },
  },
})

-- Python
local pylsp_root_binary = ""
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
