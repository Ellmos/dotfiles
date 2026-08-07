return {
	{
    "lbrayner/vim-rzip", -- yarn pnp
    lazy = false,
  },
	{
		"LintaoAmons/scratch.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    cmd = { "Scratch", "ScratchWithName", "ScratchOpen", "ScratchOpenFzf" },
		opts = {
			file_picker = "telescope",
			filetypes = { "txt", "js", "ts", "javascriptreact", "typescriptreact", "md", "json", "yaml", "sh" },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = { options = { theme = "nord" } },
	},
	{
    "famiu/bufdelete.nvim",
    keys = {
      { "<C-w>", "<CMD>Bdelete<CR>", desc = "Close current buffer" },
    },
  },
	{
		"windwp/nvim-autopairs",
    event = "InsertEnter",
		opts = { disable_filetype = { "TelescopePrompt", "vim" } },
	},
	{
		"mg979/vim-visual-multi",
		init = function()
			vim.g.VM_default_mappings = 0
		end,
		keys = {
			{ "<C-d>", "<Plug>(VM-Find-Under)", mode = { "n", "v" }, desc = "Multi cursor editing" },
			{ "<C-d>", "<Plug>(VM-Find-Subword-Under)", mode = { "x" }, desc = "Multi cursor editing" },
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	  event = { "BufReadPre", "BufNewFile" },
    cmd = { "TodoTelescope" },
    config = function(_, opts)
      require("todo-comments").setup(opts)

      vim.api.nvim_del_user_command("TodoFzfLua")
      vim.api.nvim_del_user_command("TodoTrouble")
    end
	},

	{ "JoosepAlviste/nvim-ts-context-commentstring" }, -- TODO: add commenting plugin

	{
    "dmmulroy/tsc.nvim",
    cmd = { "TSC" },
    opts = { }
  },
}
