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
  spell = true,
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
