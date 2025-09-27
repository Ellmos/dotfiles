local format_options = { lsp_fallback = true }

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black", "isort" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		jsx = { "prettier" },
		tsx = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		sql = { "sqlfmt" },
		bash = { "shfmt" },
		java = { "prettier" },
		c = { "clang_format" },
		cpp = { "clang_format" },
	},

	-- Autoformat on save
	format_on_save = function()
		if vim.g.enable_autoformat then
			return format_options
		end
	end,
})

require("mason-conform").setup()

-- Define Format command
vim.api.nvim_create_user_command("Format", function(opts)
	if opts.args == "enable" then
		vim.g.enable_autoformat = true
	elseif opts.args == "disable" then
		vim.g.enable_autoformat = false
	elseif opts.args == "" then
		require("conform").format(format_options)
	else
		error("Usage: Format [enable | disable]")
	end
end, {
	nargs = "?",
	complete = function(_, _, _)
		return { "enable", "disable" }
	end,
})
