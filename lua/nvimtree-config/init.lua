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
  disable_netrw = true,
  filters = { dotfiles = false },
  git = {},
  reload_on_bufenter = true,
  renderer = {
    add_trailing = true,
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
  sync_root_with_cwd = true,
  view = {
    adaptive_size = true,
  },
})
