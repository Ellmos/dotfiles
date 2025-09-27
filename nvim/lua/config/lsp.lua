vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach-config", { clear = true }),
	callback = function(args)
		local bufnr = args.buf

		local map = function(keymap, action, description)
			if description then
				description = "LSP: " .. description
			end

			vim.keymap.set("n", keymap, action, { desc = description, silent = true, noremap = true, buffer = bufnr })
		end

		map("<F2>", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<A-CR>", vim.lsp.buf.code_action, "Code Action")

		map("gd", vim.lsp.buf.definition, "[G]oto [d]efinition")
		map("gD", vim.lsp.buf.hover, "[G]oto [D]ocumentation")
		map("gd", "<Cmd>Telescope lsp_definitions<CR>", "[G]oto [d]efinitions")
		map("gr", "<Cmd>Telescope lsp_references<CR>", "[G]oto [R]eferences")
		map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
		map("gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "[G]oto [P]review Definition")
		map("<leader>d", vim.diagnostic.open_float, "[D]iagnostic")

		map("<leader>ds", "<Cmd>Telescope lsp_document_symbols<CR>", "[D]ocument [S]ymbols")
		map("<leader>ws", "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "[W]orkspace [S]ymbols")
	end,
})

local servers = {
	clangd = {}, -- C, C++
	pyright = {}, -- Python
	html = {}, -- HTML
	ts_ls = {}, -- TypeScript & JavaScript
	cssls = {}, -- CSS
	tailwindcss = {}, -- Tailwind
	jsonls = {}, -- JSON
	-- jdtls = {}, -- Java
	lemminx = {}, -- XML
	yamlls = {}, -- YAML
	sqlls = {}, -- SQL
	dockerls = {}, -- Docker
	csharp_ls = {}, -- C#
	angularls = {}, -- Angular
	bashls = { -- Bash
		default_config = {
			cmd = { "bash-language-server", "start" },
			filetypes = { "sh" },
		},
	},
	lua_ls = { -- Lua
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = { globals = { "vim" } },
			completion = {
				callSnippet = "Replace",
			},
		},
	},
}

require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = vim.tbl_keys(servers),
})

require("lsp-lens").setup({ enable = false })
