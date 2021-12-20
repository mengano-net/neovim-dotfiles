-- First clear any possible maps present on "<Space>"
vim.api.nvim_set_keymap("","<Space>", "<Nop>", {noremap = true, silent = true})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.leader = ' '

local options = {
  smartcase = true,
  laststatus = 2,
  hlsearch = true,
  incsearch = true,
  ignorecase = false,
  termguicolors = true,
  background = 'dark',
  ruler = true,
  writebackup = false,
  swapfile = false,
  pastetoggle = '<F2>',
  backspace = 'indent,eol,start',
  showcmd = false,
  showmode = false,
  wildoptions = 'pum',
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
  wrap = false,
  number = true,
  relativenumber = true,
  cul = true,
  cuc = true,
  colorcolumn = '100',
  signcolumn = 'yes:2',
  clipboard = "unnamedplus",
  autoindent = true,
  expandtab = true,
  scrolloff = 5,
  sidescrolloff = 5,
  dictionary = '/usr/share/dict/words',
  conceallevel = 0,
  cmdheight = 2,
}

for key, value in pairs(options) do
  vim.opt[key] = value
end
vim.opt.shortmess:append "c"
vim.opt.whichwrap:append "<,>,[,],h,l"
vim.opt.iskeyword:append "-,_"


local buffer_options = {
  tabstop = 2,
  shiftwidth = 2,
  expandtab = true
}

for key, value in pairs(buffer_options) do
  vim.bo[key] = value
end


vim.cmd[[
syntax enable
filetype plugin indent on

augroup highlight_on_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=750}
augroup END

" Unset paste mode aboue on InsertLeave action, that is leaving insert mode
autocmd InsertLeave * silent! set nopaste

" Spelling mistakes will be colored up red
hi SpellBad cterm=underline ctermfg=203 guifg=#ff5f5f
hi SpellLocal cterm=underline ctermfg=203 guifg=#ff5f5f
hi SpellRare cterm=underline ctermfg=203 guifg=#ff5f5f
hi SpellCap cterm=underline ctermfg=203 guifg=#ff5f5f

" Not needed since  I'm  using toggleterm plugin, which does this.
" No lines on terminal window, also go stright into insert mode
" au TermOpen * silent! setlocal nonumber norelativenumber
" au TermOpen * silent! startinsert

" Todua
let g:netrw_liststyle = 3
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'              " hide dotfiles on load
let g:netrw_banner = 0
let g:netrw_winsize = 30                                    " width in percent
let g:netrw_browser_split = 4                               " open in prior windoww
let g:netrw_altv = 1                                        " open splits to the right
let g:netrw_sort_sequence = '[\/]$,*'                       " sort directories first, files after
let g:netrw_keepdir = 0                                     " syn current and browsing directories

function! ToggleNetrw()
  let i = bufnr("$")
  let wasOpen = 0
  while (i >= 1)
    if (getbufvar(i, "&filetype") == "netrw")
      silent exe "bwipeout " . i
      let wasOpen = 1
    endif
    let i-=1
  endwhile
  if !wasOpen
    silent Lexplore
  endif
endfunction
map <leader>t :call ToggleNetrw() <CR>

augroup netrw_buffers
  autocmd!
  autocmd filetype netrw :set signcolumn="no"
augroup END

]]
