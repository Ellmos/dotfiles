local lint = require("lint")

lint.linters_by_ft = {
	lua = { "luacheck" },
	python = { "ruff" },
	-- javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	jsx = { "eslint_d" },
	tsx = { "eslint_d" },
	html = { "htmlhint" },
	css = { "stylelint" },
	json = { "jsonlint" },
	-- yaml = { "yamllint" },
	-- markdown = { "markdownlint" },
	-- sql = { "sqlfluff" },
	dockerfile = { "hadolint" },
	bash = { "shellcheck" },
	go = { "golangcilint" },
}

require("mason-nvim-lint").setup({
	ignore_install = { "custom_formatter" },
})

-- Auto-trigger linting on save and buffer changes
vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged", "InsertLeave" }, {
	callback = function()
		lint.try_lint()
	end,
})

-- Show linters for the current buffer's file type
vim.api.nvim_create_user_command("LintInfo", function()
	local filetype = vim.bo.filetype
	local linters = require("lint").linters_by_ft[filetype]

	if linters then
		print("Linters for " .. filetype .. ": " .. table.concat(linters, ", "))
	else
		print("No linters configured for filetype: " .. filetype)
	end
end, {})
