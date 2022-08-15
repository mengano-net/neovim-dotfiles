-- skip if module(s) isn't loaded
local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

local term_size = function(term)
	if term.direction == "horizontal" then
		-- return 20
		return vim.o.lines * 0.4
	elseif term.direction == "vertical" then
		return vim.o.columns * 0.4
	end
end

toggleterm.setup({
	open_mapping = [[<c-\>]],
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 1,
	start_in_insert = true,
	persist_size = true,
	-- direction = 'horizontal',
	-- direction = 'float',
	shell = "zsh",
	-- size = term_size,
	size = 20,
	close_on_exit = true,
	float_opts = {
		border = "double",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
		-- width = vim.o.columns * 0.9,
		-- height = vim.o.lines * 0.5,
	},
})
