return {
	"nvimdev/dashboard-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VimEnter",
	config = function()
		local home = os.getenv("HOME")

		require("dashboard").setup({
			theme = "doom",
			config = {
				center = {
					{
						icon = "  ",
						desc = "Recent Files                          ",
						action = "Telescope oldfiles",
						key = "a",
						icon_hl = "Title",
						desc_hl = "String",
						key_hl = "Number",
					},
					{
						icon = "󰥨  ",
						desc = "Recent Projects                       ",
						action = ":lua require('telescope').extensions.project.project({ display_type = 'full'  })",
						key = "b",
						icon_hl = "Title",
						desc_hl = "String",
						key_hl = "Number",
					},
					{
						icon = "󰱼  ",
						desc = "Find File                             ",
						action = "Telescope find_files",
						key = "c",
						icon_hl = "Title",
						desc_hl = "String",
						key_hl = "Number",
					},
					{
						icon = "  ",
						desc = "Find Word                             ",
						action = "Telescope live_grep",
						key = "d",
						icon_hl = "Title",
						desc_hl = "String",
						key_hl = "Number",
					},
					{
						icon = "  ",
						desc = "Edit Dotfiles                         ",
						action = ":e $HOME/Documents/dotfiles/",
						key = "e",
						icon_hl = "Title",
						desc_hl = "String",
						key_hl = "Number",
					},
					{
						icon = "  ",
						desc = "Open Current Folder                   ",
						action = ":e .",
						key = "f",
						icon_hl = "Title",
						desc_hl = "String",
						key_hl = "Number",
					},
					{
						icon = "  ",
						desc = "Open Scratch File                     ",
						action = ":Scratch",
						key = "g",
						icon_hl = "Title",
						desc_hl = "String",
						key_hl = "Number",
					},
				},
			},
			preview = {
				command = "lolcat",
				file_path = home .. "/.config/nvim/lua/plugins/startimage.cat",
				file_height = 10,
				file_width = 43,
			},
		})
	end,
}
