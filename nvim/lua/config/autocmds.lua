-- Disable auto comment on new line
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

-- -- attack lsp keybinds
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	group = vim.api.nvim_create_augroup("lsp-attach-config", { clear = true }),
-- 	callback = function(args)
-- 		local bufnr = args.buf
--
-- 		local map = function(keymap, action, description)
-- 			if description then
-- 				description = "LSP: " .. description
-- 			end
--
-- 			vim.keymap.set("n", keymap, action, { desc = description, silent = true, noremap = true, buffer = bufnr })
-- 		end
--
-- 		map("<F2>", vim.lsp.buf.rename, "Rename")
-- 		map("<A-CR>", function()
-- 			vim.lsp.buf.code_action({ context = { only = { "quickfix" } } })
-- 		end, "Code Action")
--
-- 		map("gd", vim.lsp.buf.definition, "[G]oto [d]efinition")
-- 		map("gD", vim.lsp.buf.hover, "[G]oto [D]ocumentation")
-- 		map("gd", "<Cmd>Telescope lsp_definitions<CR>", "[G]oto [d]efinitions")
-- 		map("gr", "<Cmd>Telescope lsp_references<CR>", "[G]oto [R]eferences")
-- 		map("gi", "<Cmd>Telescope lsp_implementations<CR>", "[G]oto [I]mplementation")
-- 		map("gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "[G]oto [P]review Definition")
-- 		map("<leader>d", vim.diagnostic.open_float, "[D]iagnostic")
--
-- 		map("<leader>fs", "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "[F]ind [S]ymbols")
-- 	end,
-- })
--


vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.defer_fn(function()
			vim.cmd("Lazy")
		end, 10)
	end,
})
