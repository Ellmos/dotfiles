-- Disable auto comment on new line
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		vim.defer_fn(function()
-- 			vim.cmd("Lazy")
-- 		end, 10)
-- 	end,
-- })
