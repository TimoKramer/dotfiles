local wt = require 'wezterm';

local is_windows = wt.target_triple:match("windows") ~= nil

local function join(...)
  local sep = is_windows and [[\]] or "/"
  return table.concat({ ... }, sep)
end

local home = wt.home_dir
local color_scheme_dirs = join(home, ".config", "wezterm", "colors")

return {
	color_scheme_dirs = { color_scheme_dirs },
	color_scheme = 'modus-operandi',
    font_size = 11.0,
    hide_tab_bar_if_only_one_tab = true,
}
