-- Exit if can't load module
local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

gitsigns.setup({
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  attach_to_untracked = true,
  keymaps = {
  noremap = true,
  -- ['n <leader>hj'] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'"},
  -- ['n <leader>hk'] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns prev_hunk<CR>'"},
  -- ['n <leader>hs'] = '<cmd>Gitsigns stage_hunk<CR>',
  -- ['n <leader>hu'] = '<cmd>Gitsigns undo_stage_hunk<CR>',
  -- ['n <leader>hr'] = '<cmd>Gitsigns reset_hunk<CR>',
  -- ['n <leader>hR'] = '<cmd>Gitsigns reset_buffer<CR>',
  -- ['n <leader>hp'] = '<cmd>Gitsigns preview_hunk<CR>',
  -- ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
  -- ['n <leader>hS'] = '<cmd>Gitsigns stage_buffer<CR>',
  -- ['n <leader>hU'] = '<cmd>Gitsigns reset_buffer_index<CR>',
  -- Text objects
  -- ['o ih'] = ':<C-U>Gitsigns select_hunk<CR>',
  -- ['x ih'] = ':<C-U>Gitsigns select_hunk<CR>'
	},
})
