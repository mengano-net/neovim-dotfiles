-- Test
-- In any of the above examples, to replicate the behavior |setlocal|, use
-- `vim.opt_local`. Additionally, to replicate the behavior of |setglobal|, use
-- `vim.opt_global`.
-- let g:vsnip_snippet_dir = expand('~/.config/nvim/lua/vim-vsnip-config/vsnippet~'

-- local options = {
-- 	vsnip_snippet_dir = "expand('~/.config/nvim/lua/vim-vsnip-config/vsnippet~')",
-- }

vim.cmd([[
  let g:vsnip_snippet_dir = expand('~/.config/nvim/lua/vim-vsnip-config/vsnippet')
]])

-- for key, value in pairs(options) do
-- 	vim.g[key] = value
-- end

-- vim.g.vsnip_snippet_dir = "expand('~/.config/nvim/lua/vim-vsnip-config/vsnippet~')"
