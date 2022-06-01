-- skip if module(s) isn't loaded
local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- most of these options have now been migrated to the setup function, see this for an example of
-- such migrations: bit.ly/3vIpEOJ
-- local global_options = {
-- }

-- for key, value in pairs(global_options) do
--   vim.g[key] = value
-- end

nvimtree.setup({
  actions = {
    open_file = {
      quit_on_open = true,
      resize_window = true,
    },
  },
  disable_netrw = true,
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = " ",
      info = " ",
      warning = " ",
      error = " ",
    },
  },
  filters = { dotfiles = true },
  git = { ignore = true },
  renderer = {
    indent_markers = {
      enable = false,
    },
    highlight_opened_files = "all",
    highlight_git = true,
    icons = {
      padding = " ",
      glyphs = {
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          deleted = "",
          untracked = "U",
          ignored = "◌",
        },
      },
    },
  },
})
