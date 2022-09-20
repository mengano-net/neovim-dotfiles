local _general = vim.api.nvim_create_augroup("general_settings", { clear = true })
local _git = vim.api.nvim_create_augroup("git", { clear = true })
local _python = vim.api.nvim_create_augroup("python", { clear = true })
local _documentation = vim.api.nvim_create_augroup("documentation", { clear = true })
local _yaml = vim.api.nvim_create_augroup("yaml", { clear = true })

----------------------------------------------------------------------
--        To reset window options that had been set by other autocmd--
--        This is needed because win options are set for the        --
--                 whole window, not only buffers,                  --
--             thus they carry over to other buffers.               --
--         I'd be nice to have these options available for buffers  --
----------------------------------------------------------------------

local function reset_win_options()
  vim.api.nvim_win_set_option(0, "colorcolumn", "100")
  vim.api.nvim_win_set_option(0, "spell", false)
  vim.api.nvim_win_set_option(0, "linebreak", false)
  vim.api.nvim_win_set_option(0, "conceallevel", 0)
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

----------------------------------------------------------------------
--                               Git                                --
----------------------------------------------------------------------
local function filetypes_git()
  vim.cmd("setlocal spell spelllang=en_us")
  vim.cmd("startinsert | 1")
end

vim.api.nvim_create_autocmd("FileType", {
  group = _git,
  pattern = { "gitcommit", "gitrebase" },
  -- command = "startinsert | 1",
  callback = filetypes_git,
})

----------------------------------------------------------------------
--                           Python files                           --
----------------------------------------------------------------------
local function filetypes_python() vim.api.nvim_win_set_option(0, "colorcolumn", "80") end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = _python,
  pattern = { "*.py" },
  callback = filetypes_python,
})

----------------------------------------------------------------------
--                     Documentation file types                     --
----------------------------------------------------------------------
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

----------------------------------------------------------------------
--                               Yaml                               --
----------------------------------------------------------------------
local yaml_file_options = function()
  vim.cmd "TSBufDisable highlight"
  -- vim.api.nvim_set_hl(0, "yamlPlainScalar", { fg = '#ce9178', bg = 'NONE' })
  -- vim.api.nvim_set_hl(0, "yamlTSField", { fg = '#569cd6', bg = 'NONE' })
  -- vim.cmd "TSBufEnable highlight"
end

vim.api.nvim_create_autocmd("BufEnter", {
  group = _yaml,
  pattern = { "*.yaml", "*.yml" },
  callback = yaml_file_options,
})

vim.cmd([[
]])
