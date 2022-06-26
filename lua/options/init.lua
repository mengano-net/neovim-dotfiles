-- First clear any possible maps present on my <leader>, I'm currently using "<Space>"
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
  scrolloff = 10,
  sidescrolloff = 5,
  dictionary = "/usr/share/dict/words",
  conceallevel = 0,
  cmdheight = 2,
  fileencoding = "utf-8",
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
-- Highlight yanked text for 750 miliseconds
local augroup_highlight_on_yank = vim.api.nvim_create_augroup(
  "test",
  { clear = true }
)
vim.api.nvim_create_autocmd(
  "TextYankPost",
  {
    command = "lua vim.highlight.on_yank {higroup='IncSearch', timeout=750}",
    group = augroup_highlight_on_yank
  }
)

-- To reset window options that had been set by other autocmd, this is needed because win options
-- are set for the whole window, not only buffers, thus they carry over to other buffers. I'd be
-- nice to have these options available for buffers.
local function reset_win_options()
  vim.api.nvim_win_set_option(0, "colorcolumn", "100")
  vim.api.nvim_win_set_option(0, "spell", false)
  vim.api.nvim_win_set_option(0, "linebreak", false)
end

local augroup_reset_win_options_when_bufleave = vim.api.nvim_create_augroup(
  "reset win options",
  { clear = true }
)
vim.api.nvim_create_autocmd(
  "BufLeave",
  {
    pattern = { "*" },
    callback = reset_win_options,
    group = augroup_reset_win_options_when_bufleave
  }
)

-- Python filetypes
local function filetypes_python()
  vim.api.nvim_win_set_option(0, "colorcolumn", "80")
end

local augroup_filetype_python = vim.api.nvim_create_augroup(
  "filetype python",
  { clear = true }
)
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.py" },
  callback = filetypes_python,
  group = augroup_filetype_python
})

-- Unset paste mode on InsertLeave action, leaving insert mode
local augroup_set_nopaste_on_insert_leave = vim.api.nvim_create_augroup(
  "set nopaste",
  { clear = true }
)
vim.api.nvim_create_autocmd(
  "InsertLeave",
  { command = "silent! set nopaste", group = augroup_set_nopaste_on_insert_leave }
)

-- "Documentation" filetypes
local function filetypes_documentation()
  vim.api.nvim_win_set_option(0, "spell", true)
  vim.api.nvim_buf_set_option(0, "fo", "aw2tq")
  vim.api.nvim_win_set_option(0, "linebreak", true)
end

local augroup_filetype_documentation = vim.api.nvim_create_augroup(
  "filetypes_documentation",
  { clear = true }
)
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.md", "*.tex" },
  callback = filetypes_documentation,
  group = augroup_filetype_documentation,
})

-- vimscript section, in case I need to implement vimscript options, au, etc.
vim.cmd([[
" syntax enable
" filetype plugin indent on
]])
