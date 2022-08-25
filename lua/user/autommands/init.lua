----------------------------------------------------------------------------------------
-- General
----------------------------------------------------------------------------------------

local _general = vim.api.nvim_create_augroup("general_settings", { clear = true })
local _git = vim.api.nvim_create_augroup("git", { clear = true })
local _python = vim.api.nvim_create_augroup("python", { clear = true })
local _documentation = vim.api.nvim_create_augroup("documentation", { clear = true })

-- To reset window options that had been set by other autocmd. This is needed because win options
-- are set for the whole window, not only buffers, thus they carry over to other buffers. I'd be
-- nice to have these options available for buffers.
local function reset_win_options()
  vim.api.nvim_win_set_option(0, "colorcolumn", "100")
  vim.api.nvim_win_set_option(0, "spell", false)
  vim.api.nvim_win_set_option(0, "linebreak", false)
end

vim.api.nvim_create_autocmd("BufLeave", {
  group = _general,
  pattern = { "*" },
  callback = reset_win_options,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = _general,
  command = "lua vim.highlight.on_yank { higroup='IncSearch', timeout=750}",
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = _general,
  command = "silent! set nopaste",
})

----------------------------------------------------------------------------------------
-- git
----------------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("FileType", {
  group = _git,
  pattern = { "gitcommit", "gitrebase" },
  command = "startinsert | 1",
})

----------------------------------------------------------------------------------------
-- Python
----------------------------------------------------------------------------------------

local function filetypes_python() vim.api.nvim_win_set_option(0, "colorcolumn", "80") end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = _python,
  pattern = { "*.py" },
  callback = filetypes_python,
})

----------------------------------------------------------------------------------------
-- Documentation file types
----------------------------------------------------------------------------------------

local documentation_file_options = function()
  vim.api.nvim_win_set_option(0, "conceallevel", 2)
  vim.api.nvim_win_set_option(0, "spell", true)
  vim.bo.fo = "awtq"
  vim.wo.linebreak = true
end

vim.api.nvim_create_autocmd("BufEnter", {
  group = _documentation,
  pattern = { "*.md", "*.tex" },
  callback = documentation_file_options,
})

vim.cmd([[
]])
