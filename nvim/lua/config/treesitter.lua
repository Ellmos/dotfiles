require("nvim-treesitter.configs").setup({
	auto_install = true,
	ensure_installed = {
		"c",
        "cpp",
        "c_sharp",
        "python",
		"lua",
		"make",
		"javascript",
		"html",
		"css",
        "markdown"
	},
	sync_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
})

