-- skip if module(s) isn't loaded
local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local global_options = {
	nvim_tree_highlight_opened_files = 1,
	nvim_tree_git_hl = 1,
}

for key, value in pairs(global_options) do
	vim.g[key] = value
end

vim.g.nvim_tree_show_icons = {
	git = 1,
}

vim.g.nvim_tree_icons = {
	git = {
		unstaged = "",
		staged = "S",
		unmerged = "",
		renamed = "➜",
		deleted = "",
		untracked = "U",
		ignored = "◌",
	},
}

nvimtree.setup({
  actions = {
    open_file = {
      quit_on_open = true,
      resize_window = true,
    },
  },
  diable_netrw,
	filters = { dotfiles = true },
	git = { ignore = true },
	quit_on_open = true,
  renderer = {
    indent_markers = {
      enable = false,
    },
  },
	view = { autoresize = true },
})
