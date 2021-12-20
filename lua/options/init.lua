-- First clear any possible maps present on "<Space>"
vim.api.nvim_set_keymap("","<Space>", "<Nop>", {noremap = true, silent = true})
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.leader = ' '

vim.o.smartcase = true
vim.o.laststatus = 2
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = false
vim.o.termguicolors = true
vim.o.background = 'dark'
vim.o.ruler = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.pastetoggle = '<F2>'
vim.o.backspace = 'indent,eol,start'
vim.o.showcmd = false
vim.o.showmode = false
vim.o.wildoptions = 'pum'
vim.o.pumheight = 20
vim.o.wildignore = vim.o.wildignore .. '*.swp,.git,.gitignore,node_modules'
vim.o.path = vim.o.path .. '.,**,'
vim.o.hidden = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.wildmenu = true
vim.o.redrawtime = 250
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
vim.o.textwidth = 99
vim.o.updatetime = 150
vim.o.backup = false
vim.o.timeoutlen = 1000
vim.o.list = true
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.cul = true
vim.o.cuc = true
vim.o.colorcolumn = '100'
vim.o.signcolumn = 'yes:2'
vim.o.clipboard = "unnamedplus"
-- vim.o.mouse = "a"      -- mouse support
vim.o.autoindent = true
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- not neededing since I'm running plugin: akinsho/bufferline.nvim
-- vim.o.showtabline = 2
vim.o.dictionary = '/usr/share/dict/words'
vim.o.conceallevel = 0
vim.opt.shortmess:append "c"
vim.o.cmdheight = 2

vim.cmd[[
set whichwrap+=<,>,[,],h,l
set iskeyword+=-,_
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
