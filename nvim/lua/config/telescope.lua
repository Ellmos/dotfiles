require("telescope").setup({
	pickers = {
		find_files = { hidden = true },
	},
	extensions = {
		["ui-select"] = { require("telescope.themes").get_dropdown() },
	},
})
require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")
require("telescope").load_extension("projects")
require("telescope").load_extension("yank_history")
require("telescope").load_extension("dap")
require("telescope").load_extension("before")
