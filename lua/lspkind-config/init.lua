-- Exit if can't load module(s)
local status_ok, lspkind = pcall(require, "lspkind")
if not status_ok then
	return
end

lspkind.init({
	mode = "symbol_text",
	symbol_map = {
		Text = "",
		Method = "ƒ",
		Function = "ﬦ",
		Constructor = "",
		Variable = "",
		Class = "",
		Interface = "ﰮ",
		Module = "",
		Property = "",
		Unit = "",
		Value = "",
		Enum = "了",
		Keyword = "",
		Snippet = "﬌",
		Color = "",
		File = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Event = "",
	},
})
