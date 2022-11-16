local wt = require 'wezterm';

local is_windows = wt.target_triple:match("windows") ~= nil

local function join(...)
  local sep = is_windows and [[\]] or "/"
  return table.concat({ ... }, sep)
end

local home = wt.home_dir
local color_scheme_dirs = join(home, ".config", "wezterm", "colors")

local keys = is_windows and {
    {
        key = 'T',
        mods = 'CTRL|SHIFT',
        action = wt.action.SpawnCommandInNewTab {
            args = { 'wsl', '--cd', '~' },
        },
    },
    {
        key = 'N',
        mods = 'CTRL|SHIFT',
        action = wt.action.SpawnCommandInNewWindow {
            args = { 'wsl', '--cd', '~' },
        },
    },
    {
        key = '%',
        mods = 'CTRL|SHIFT|ALT',
        action = wt.action.SplitHorizontal {
            args = { 'wsl', '--cd', '~' },
        },
    },
    {
        key = '"',
        mods = 'CTRL|SHIFT|ALT',
        action = wt.action.SplitVertical {
            args = { 'wsl', '--cd', '~' },
        },
    },
} or {}

return {
    color_scheme_dirs = { color_scheme_dirs },
    color_scheme = 'modus-operandi',
    font_size = 9.0,
    hide_tab_bar_if_only_one_tab = true,
    keys = keys,
}
