return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			model = "auto",
			trusted_tools = { "file", "glob", "grep" },

			-- Disable all default mappings
			mappings = {
				complete = false,
				reset = {
					normal = "<C-w>",
					insert = "<C-w>",
				},
				accept_diff = {
					normal = "<S-CR>",
				},
				show_info = {
					normal = "si",
				},
				show_diff = {
					normal = "sd",
				},
				show_help = {
					normal = "sh",
				},
				yank_diff = false,
			},
		},
		keys = {
			{ "<leader>c", "<Cmd>CopilotChatToggle<CR>", mode = { "n", "v" }, desc = "Toggle CopilotChat" },
		},
	},
	{
		"github/copilot.vim",
	  event = "InsertEnter",
	},
}
