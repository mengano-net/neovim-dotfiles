-- Firstly, let's clear any possible existing maps set on "<Space>"
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.leader = " "

local options = {
  autoindent = true,
  autoread = true,
  autowrite = true,
  background = "dark",
  backspace = "indent,eol,start",
  backup = false,
  breakindent = true,
  breakindentopt = "shift:2",
  clipboard = "unnamedplus",
  cmdheight = 1,
  colorcolumn = "100",
  conceallevel = 0,
  completeopt = "menu,menuone,preview,noselect,noinsert",
  cul = true,
  cuc = false,
  dictionary = "/usr/share/dict/words",
  diffopt = { "filler", "internal", "algorithm:histogram", "indent-heuristic" },
  expandtab = true,
  fileencoding = "utf-8",
  hidden = true,
  hlsearch = true,
  incsearch = true,
  ignorecase = false,
  laststatus = 2,
  list = true,
  number = true,
  mouse = "n",
  ruler = true,
  swapfile = false,
  pastetoggle = "<F2>",
  pumheight = 20,
  redrawtime = 250,
  relativenumber = true,
  showcmd = false,
  showmode = false,
  spell = false,
  smartcase = true,
  scrolloff = 5,
  shiftwidth = 2,
  signcolumn = "yes:2",
  sidescrolloff = 5,
  softtabstop = 2,
  splitright = true,
  splitbelow = true,
  showbreak = "↳",
  termguicolors = true,
  tabstop = 2,
  textwidth = 99,
  timeoutlen = 1000,
  updatetime = 150,
  wrap = true,
  writebackup = false,
  wildoptions = "pum",
  wildmenu = true,
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-,_")
vim.opt.listchars:append("eol:↴")

local buffer_options = {
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
}

for key, value in pairs(buffer_options) do
  vim.bo[key] = value
end

-- Disable unused builtin plugins.
vim.g.loaded_gzip = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
