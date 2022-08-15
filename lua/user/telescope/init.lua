-- Exit if can't load module
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local M = {}

--[[
Opens a file picker with Neovim configuration files to make a quick edit,
useful to make quick changes to Neovim's configuration without having to CDW
]]
function M.neovim_config()
  -- local cwd_neovim_config = ''
  -- local USER = vim.fn.expand('$USER')
  -- if vim.fn.has('unix') == 1 then
  --     cwd_neovim_config = '/home/' .. USER .. '/.config/nvim'
  -- elseif vim.fn.has('mac') == 1 then
  --     cwd_neovim_config = '/Users/' .. USER .. '/.config/nvim'
  -- else
  --     print('Cannot detect your OS')
  --     cwd = '~/.config/nvim'
  -- end
  local opts = {
    prompt_title = "\\ NVim Config /",
    previewer = false,
    cwd = "~/.config/nvim",
    file_ignore_patterns = { "node_modules" },
    prompt_prefix = "  ",
    layout_config = {
      width = 0.5,
    },
  }
  require("telescope.builtin").find_files(opts)
end

-- Returns true if current directory is a git worktree
function M.is_git_worktree()
  local _, ret, stderr = require("telescope.utils").get_os_command_output({
    "git",
    "rev-parse",
    "--is-inside-work-tree",
  })
  -- print(vim.inspect(ret))
  if ret == 0 then
    return true
  else
    return false
  end
end

function M.git_files()
  --[[ local opts = {
    prompt_title = "\\ Git Files /",
    follow = 'true',
    -- hidden = 'false',
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.95,
    },
  }
  require'telescope.builtin'.git_files(opts) ]]
  require("telescope.builtin").git_files(require("telescope.themes").get_ivy({
    prompt_title = "Git Files",
    follow = "true",
    prompt_prefix = "  ",
  }))
end

--[[
This function evaluates if we are inside a directory managed by git,
if true, it runs function git_files(), otherwise it runs telescope's
builtin file_browser() function.
]]
function M.find_files()
  local _is_git_worktree = M.is_git_worktree()
  if _is_git_worktree then
    M.git_files()
  else
    --[[ local opts = {
      prompt_title = "\\ Find Files /",
      -- previewer = 'true',
      follow = 'true',
      -- hidden = 'false',
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.95,
        preview_width = 0.65,
      },
      -- prompt_prefix = '  ',
      prompt_prefix = '  ',
      -- cwd = '%p',
      file_ignore_patterns = { "node_modules" },
    }
    require'telescope.builtin'.find_files(opts) ]]
    require("telescope.builtin").find_files(require("telescope.themes").get_ivy({
      prompt_title = "Find Files",
      follow = "true",
      prompt_prefix = "  ",
      file_ignore_patterns = { "node_modules" },
    }))
  end
end

function M.grep_within_grep()
  --[[ local opts = {
    prompt_title = "\\ Secondary Grep /",
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.9,
    },
    search = vim.fn.input('Rg> '),
  }
  require'telescope.builtin'.grep_string(opts) ]]
  require("telescope.builtin").grep_string(require("telescope.themes").get_ivy({
    prompt_title = "Secondary Grep",
    search = vim.fn.input("Rg> "),
  }))
end

function M.git_branches()
  --[[ local opts = {
    prompt_title = "\\ Git Branches /",
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.9,
    },
    prompt_prefix = '  ',
  } ]]
  local _is_git_worktree = M.is_git_worktree()
  if _is_git_worktree then
    -- require'telescope.builtin'.git_branches(opts)
    require("telescope.builtin").git_branches(require("telescope.themes").get_ivy({
      prompt_title = "Git Branches",
      prompt_prefix = "  ",
    }))
  else
    require("notify-extensions").notify("Warning", "Not a git working tree", 3, 2000)
    return
  end
end

function M.git_commits()
  --[[ local opts = {
    prompt_title = "\\ Git Commits /",
    layout_strategy = "horizontal",
    -- layout_strategy = "vertical",
    layout_config = {
      width = 0.9,
    },
    prompt_prefix = '  ',
  } ]]
  local _is_git_worktree = M.is_git_worktree()
  if _is_git_worktree then
    -- require'telescope.builtin'.git_commits(opts)
    require("telescope.builtin").git_commits(require("telescope.themes").get_ivy({
      prompt_title = "Git Commits",
      prompt_prefix = "  ",
    }))
  else
    require("notify-extensions").notify("Warning", "Not a git working tree", 3, 2000)
    return
  end
end

function M.notes()
  local opts = {
    prompt_title = "\\ Notes - IT /",
    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.65,
    },
    cwd = "~/bitbucket.org/mine/it/",
    prompt_prefix = "   ",
  }
  require("telescope.builtin").file_browser(opts)
end

function M.find_files_in_path()
  local _path = vim.fn.input("Enter Directory: ", "", "dir")
  if _path == nil or _path == "" then
    _path = vim.fn.expand("%:p:h")
  end
  require("telescope.builtin").find_files(require("telescope.themes").get_ivy({
    prompt_title = "Find in directory: " .. _path,
    search_dirs = { _path },
  }))
end

-- Adding module to the _G global variable.
_G.utils = M
return M
