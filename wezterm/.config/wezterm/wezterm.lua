local wt = require("wezterm")

local is_windows = wt.target_triple:match("windows") ~= nil

local function join(...)
	local sep = is_windows and [[\]] or "/"
	return table.concat({ ... }, sep)
end

local home = wt.home_dir
local color_scheme_dirs = join(home, ".config", "wezterm", "colors")

local keys = {
	{
		key = "C",
		mods = "CTRL",
		action = wt.action.CopyTo("ClipboardAndPrimarySelection"),
	},
	{
		key = "%",
		mods = "CTRL|SHIFT|ALT",
		action = wt.action.SplitPane({
			direction = "Left",
			command = { args = { "top" } },
			size = { Percent = 50 },
		}),
	},
}

return {
	color_scheme_dirs = { color_scheme_dirs },
	color_scheme = "dank-theme",
	font_size = 12.0,
	font = wt.font("Agave Nerd Font Mono"),
	hide_tab_bar_if_only_one_tab = true,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	keys = keys,
}
