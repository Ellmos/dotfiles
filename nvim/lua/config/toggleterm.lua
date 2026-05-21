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
