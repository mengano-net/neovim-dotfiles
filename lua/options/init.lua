-- Firstly, let's clear any possible existing maps set on "<Space>"
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.leader = " "

local options = {
  smartcase = true,
  laststatus = 2,
  hlsearch = true,
  incsearch = true,
  ignorecase = false,
  termguicolors = true,
  background = "dark",
  ruler = true,
  writebackup = false,
  swapfile = false,
  pastetoggle = "<F2>",
  backspace = "indent,eol,start",
  showcmd = false,
  showmode = false,
  wildoptions = "pum",
  pumheight = 20,
  hidden = true,
  splitright = true,
  splitbelow = true,
  wildmenu = true,
  redrawtime = 250,
  softtabstop = 2,
  tabstop = 2,
  shiftwidth = 2,
  textwidth = 99,
  updatetime = 150,
  backup = false,
  timeoutlen = 1000,
  list = true,
  wrap = true,
  number = true,
  relativenumber = true,
  cul = true,
  cuc = false,
  colorcolumn = "100",
  signcolumn = "yes:2",
  clipboard = "unnamedplus",
  autoindent = true,
  expandtab = true,
  scrolloff = 5,
  sidescrolloff = 5,
  dictionary = "/usr/share/dict/words",
  conceallevel = 0,
  cmdheight = 2,
  fileencoding = "utf-8",
  spell = false,
}

for key, value in pairs(options) do
  vim.opt[key] = value
end
vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-,_")

local buffer_options = {
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
}

for key, value in pairs(buffer_options) do
  vim.bo[key] = value
end

--
-- Autocommands
--
--
-- To reset window options that had been set by other autocmd. This is needed because win options
-- are set for the whole window, not only buffers, thus they carry over to other buffers. I'd be
-- nice to have these options available for buffers.
local function reset_win_options()
  vim.api.nvim_win_set_option(0, "colorcolumn", "100")
  vim.api.nvim_win_set_option(0, "spell", false)
  vim.api.nvim_win_set_option(0, "linebreak", false)
end

vim.api.nvim_create_autocmd("BufLeave", {
  group = vim.api.nvim_create_augroup("reset win options", { clear = true }),
  pattern = { "*" },
  callback = reset_win_options,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("bufcheck", { clear = true }),
  pattern = { "gitcommit", "gitrebase" },
  command = "startinsert | 1",
})

-- Python filetypes
local function filetypes_python()
  vim.api.nvim_win_set_option(0, "colorcolumn", "80")
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = vim.api.nvim_create_augroup("filetype python", { clear = true }),
  pattern = { "*.py" },
  callback = filetypes_python,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_on_yank", { clear = true }),
  command = "lua vim.highlight.on_yank { higroup='IncSearch', timeout=750}",
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = vim.api.nvim_create_augroup("leave_insert_set_nopaste", { clear = true }),
  command = "silent! set nopaste",
})

-- `documentation` filetypes
local documentation_file_options = function()
  vim.api.nvim_win_set_option(0, "conceallevel", 2)
  vim.api.nvim_win_set_option(0, "spell", true)
  vim.bo.fo = "awtq"
  vim.wo.linebreak = true
end

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("documentation_file_options", { clear = true }),
  pattern = { "*.md", "*.tex" },
  callback = documentation_file_options,
})

vim.cmd([[
]])
