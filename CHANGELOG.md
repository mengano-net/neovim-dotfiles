## 1.7.0 (2024-02-25)

## 1.6.0 (2024-02-25)

## 1.6.0 (2023-11-22)

### Feat

- migrated plugin manager to Lazy.nvim
- **plugin**: beacon plugin, no other config done
- **spell file**: new feature to use spell file
- **markdown**: tabstop 2 for markdown file buffers
- **mason**: options for concurrency
- **marksman**: setup function to enable toc on md files
- **chatGPT**: went back to latest commit.
- **lsp, whichkey**: adding vim.api.buf.rename()
- **winbar**: better colors and caps for winbar
- **winbar**: implemented my own module.
- **cmp-config**: cmp priority comparators
- **hrsh7th/cmp-cmdline**: deleted by mistake, added back

### Fix

- indent-blankline.nvim upgraded setup function
- performance issue
- **winbar**: issue with WinBar highlight
- **winbar**: fixing bugs
- **devicons**: fixed issue with devicons plugin.

### Refactor

- **cmp-config**: removed `cmp-cmdline` plugin.
- **cmp-config**: moved custom colorscheme changes.
- **diagnostics**: added border to float window

## 1.4.0 (2022-11-24)

## 1.5.1 (2023-04-15)

### Feat

- **treesitter**: nvim now support treesitter maps natively

### Fix

- **ChatGPT**: went to previous version due to bug
- **lualine-config**: moved git_signs to lualine_c.
- **cmp-config**: changed order of items on cmp float.
- **nvim-options**: tab space was wrongly set to 2, instead of 4
- **cmp-config**: disabling cmp-cmd for now.
- remapped submit key
- **catppuccin**: forcing italics to be off

## 1.5.0 (2023-03-22)

### Feat

- **telescope-extensions, whichkey-config**: new git shortcut to browse file commits.
- **mappings**: new map for 'x'
- **GTP3**: added plugin to converse with GPT3
- **undodir**: added undodir under ~/.cache/nvim/undodir
- **cmp**: WIP working on sorting mechanisms for cmp
- **cmp-config**: disabled auto completion whole typing comments
- **cmp-config**: disabled auto completion whole typing comments
- **luasnip**: finish luasnip implementation
- **luasnip**: WIP 1
- **cmp-config**: color highlights for auto complete window
- **vsnippet**: table for markdown
- **toggleterm**: new maps and autocommands for terminal
- several plugins
- **markdown vsnippet**: For blog sections and date
- **plugin**: installed fgheng/winbar.nvim
- **winbar**: wip, adding potential for winbar
- **telescope zoxide extension**: adding which key map
- **telescope**: adding telescope extensions
- **telescope**: adding telescope extensions
- **colorscheme**: added cubandusk
- **colorscheme**: Installed Nord
- **colorscheme**: added everblush colorscheme
- **colorscheme**: added catppuccin colorscheme

### Fix

- **lua lsp**: sumneko_lua deprecated for lua_ls
- **cmp**: adding keyword_length=5 to buffer source
- **cmp-config**: removing comparators because I don't like order it produces
- **catppuccin**: changed GitDiffDelete highlight
- **notify**: fixed
- **diagnostics**: some better options for diagnostics.config
- **cmp**: was throwing exception when hit Tab with typing first
- **cmp**: was throwing exception when hit Tab with typing first
- **cmp**: exception no longer thrown if hit tab before typing anything
- **lsp**: improving capabilities
- **catppuccin**: better colors for cmp window
- **colorscheme**: better red for GitRemove highlight
- **colorscheme**: lazy-loading nord and new highlights for git on catppuccin
- **illuminate**: added gitcommit filetype to ignore list
- **illuminate**: added filetypes to exclusion list
- **catppucinn colorscheme**: Illuminate highlight
- **IlluminatedWordText**: overriding it at colorscheme(catppuccin) setup function
- **illuminate**: eliminated underline for hi IlluminatedWordText
- **telescope-zoxide**: it requires telescope plugin
- **catppuccin**: highlight overrides for Diff*
- **cmp**: cmp_nvim_lsp.update_capabilities is deprecated
- **winbar**: added glowpreview to ignore filetypes
- **whichkey-config**: deleted deprecated, lualized LSP map
- **whichkey-config**: cleaned up, lualize a map, remove others, etc
- **toggleterm**: new border for float and removed unused code on whichkey-config
- **lualine**: timezone and added padding to git diff
- **whichkey**: several fixed, removals
- **lualine**: lualized hilight for TelescopeBorder
- **telescope**: get_ivy theme for grep picker
- **colorscheme cubandusk**: fixed branch
- **colorscheme**: moved there to colorscheme file
- **nord colorscheme**: was called twice on plugins file
- **nord colorscheme**: was called twice on plugins file
- **nvim-comment-frame**: moved config to plugin.lua
- **nvim-comment-frame**: fix issue for python
- **nvim-comment-frame**: better values for width of comment block

### Refactor

- removed plugins: glow and unused Nord color scheme
- WIP just removing some old color schemes
- **notify**: removed extraneous line.
- **telescope-extensions**: refactored the notify messages
- **lsp**: now using Glance plugin for declaration, definitions and references.
- **whichkey-config**: moved some LSP maps to whichkey
- **cmp**: removed onsails/lspkind-nvim
- **lsp**: capabilities

## 1.3.3 (2022-09-28)

### Fix

- **colorscheme**: consolidated colorchemes
- **tokyonight**: fixed setup not being applied
- **colorschemes**: Consolidated color schemes
- **toggleterm**: fix toggleterm size

## 1.3.2 (2022-09-20)

### Fix

- **treesitter**: hack for yaml TS coloring
- **lsp**: sumneko_binary wasn't found
- **init**: moving colorscheme to the end
- **gitsign**: updated project branch
- **null-ls**: added ignore options for flake8
- **null-ls**: added code actions and formatting

### Feat

- **comment-frame**: added plugin to intelligently add comment blocks
- **comment-frame**: added plugin to intelligently add comment blocks
- **utils**: added helper functions: P() and R()
- **null_ls**: adding code_actions and formatting
- **bufferline**: adding maps to move and select bufferlines

## 1.3.1 (2022-09-06)

### Feat

- **python**: added prettier and autopep8 formatters

### Fix

- **bufferline**: slanted tab border.
- **diagnostics**: signs were disabled by default :(

## 1.3.0 (2022-09-04)

### Fix

- **whichkey-config**: updated now that LSPInstalled is gone.
- **lsp**: pylsp won't install, so I'm using pyright for now
- **autocommands**: added filetype gitcommit to have 'setlocal spell'
- **cmp-lsp**: adding floating diagnostics back
- **telescope**: issue with find_files()
- **nvim-options**: rolled back cmdheight to 1

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
