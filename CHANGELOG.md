## 1.2.0 (2022-09-01)

### Fix

- **colorscheme**: fixing colorscheme.lua
- **illuminate**: added this plugin into lsp's on_attach function
- **lualine**: issue with onedark dependency
- **several**: see notes below
- **onedark**: lazy_loaded config into plugins.lua
- **lualine and whichkey**: see below
- **lualine**: added filetypes to lualine exclusions
- **diagnostic**: they dissaper when I run vim.lsp.format()
- **illuminate**: new plugin illuminate.
- **cmp**: see https://github.com/sumneko/lua-language-server/issues/1487
- **options**: formatting and few minor adjustments

### Feat

- **hunks**: now we have 2 flavours of git hunk blame, short and long

## 1.1.0 (2022-08-26)

### Fix

- **autopairs**: missing conf if you use cmp, which I do
- **autommands**: refinements to resset_win_options()
- **bur.formatting**: another attemp to fix wrong tabbing.
- **cmp**: temp fix for formatting on save
- **nvimtree**: now showing hidden files
- **cmp**: documentHighlight autocmd needed fix on 'pattern'
- **cmp**: highlight, formatting and deprecation
- **bufferline**: configuration must be in options
- **nvim-tree**: preferences changes

### Feat

- **whichkey**: added map to show git blame for line
- **lualine**: reorganization and extra functionality
- **lualine**: added exceptions for toggleterm filetype
- **whichkey**: new groups for LSP and terminal
- **spell, surround**: new plugin, other fixes.

## 1.0.4 (2022-08-16)

## 1.0.3 (2022-08-15)

## 1.0.2 (2022-08-15)

## 1.0.1 (2022-08-15)

### Feat

- **all**: First commit, tag: v1.0.0
