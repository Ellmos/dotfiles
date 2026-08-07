return {
	"akinsho/toggleterm.nvim",
  cmd = "ToggleTerm",
	keys = {
		{ "<leader>t", "<CMD>ToggleTerm<CR>", desc = "Toggle Terminal" },
		{ "<ESC>", "<C-\\><C-n>", mode = "t", desc = "Exit terminal mode" },
	},
	config = function()
		require("toggleterm").setup()

		vim.api.nvim_create_autocmd("ExitPre", {
			pattern = "*",
			callback = function()
				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
					if vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
						vim.api.nvim_buf_delete(buf, { force = true })
					end
				end
			end,
		})
	end,
}
