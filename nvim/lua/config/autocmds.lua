-- Disable cursorline on unfocused windows
vim.api.nvim_create_autocmd({ "WinLeave" }, {
	callback = function()
		vim.opt_local.cursorline = false
	end,
})
vim.api.nvim_create_autocmd({ "WinEnter" }, {
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

-- Disable auto comment on new line
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

-- For debug purpose (open Lazy on startup)
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		vim.defer_fn(function()
-- 			vim.cmd("Lazy")
-- 		end, 10)
-- 	end,
-- })