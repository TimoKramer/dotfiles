local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!.git/*")

telescope.setup({
	defaults = {
		vimgrep_arguments = vimgrep_arguments,
                layout_config = { prompt_position = "top" }
	},
	pickers = {
		find_files = {
			hidden = true,
                        file_ignore_patterns = { ".git/", ".node_modules/", ".mypy_cache/", "__pycache__/" },
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" }
		},
	},
})
