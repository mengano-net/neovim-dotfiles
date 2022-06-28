-- Exit if can't load module(s)
local is_cmp_available, cmp = pcall(require, "cmp")
if not is_cmp_available then
  -- print("require'cmp' failed to load")
  require('notify-extensions').notify("Library error", "require'cmp' failed to load", 3, 2000)
  return
end

local is_lspkind_available, lspkind = pcall(require, "lspkind")
if not is_lspkind_available then
  -- print("require'lspkind' failed to load")
  require('notify-extensions').notify("Library error", "require'lspkind' failed to load", 3, 2000)
  return
end

local is_luasnip_available, luasnip = pcall(require, "luasnip")
if not is_luasnip_available then
  -- print("require'luasnip' failed to load")
  require('notify-extensions').notify("Library error", "require'luasnip' failed to load", 3, 2000)
  return
end

vim.api.nvim_set_option("completeopt", "menu,menuone,preview,noselect,noinsert")

-- Functions to implement autocomplete on the custom <Tab> and
-- <S-Tab> mappings below
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

-- Setup nvim-cmp.
-- TJDevries had this on one of his videos, not sure what it does.
-- lspkind.init()

-- cmp setup
cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body)
      luasnip.lsp_expand(args.body)
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert {
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-f>"] = cmp.mapping.scroll_docs(-4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) == 1 then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  -- the order of these sources dictates appearance on complete menu
  sources = cmp.config.sources({
    { name = "buffer", keyword_length = 4 }, -- type min of 4 chars before autocomplete kicks in
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = 'luasnip' },
    { name = "treesitter" },
    { name = "path" },
    { name = "spell" },
  }),

  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      maxwidth = 50,
      menu = {
        buffer = "[buffer]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[lua_api]",
        path = "[path]",
        spell = "[spell]",
      },
    }),
  },

  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },

  experimental = {
    ghost_text = true,
  },

  -- completion = {
  --   keyword_length = 1,
  --   completeopt = "menu,noselect"
  -- },

  view = {
    entries = "experimental",
    -- entries = "custom",
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
