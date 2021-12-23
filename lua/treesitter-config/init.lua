-- Exit if can't load module
local status_ok, treesitter = pcall(require, "nvim-tressitter")
if not status_ok then
  return
end

treesitter.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {"lua", "yaml", "bash", "python" },
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  incremental_selection = { enable = true },
  indent = { enable = true },
}
