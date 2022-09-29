-- Exit if can't load module
local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

-- require('nvim-treesitter.configs').setup {
treesitter.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  autopairs = { enable = true },
  ensure_installed = { "lua", "bash", "python" },
  ignore_install = {},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  incremental_selection = { enable = true },
  indent = { enable = true },
  playground = { enable = true },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
    sync_install = false,
  },
}
