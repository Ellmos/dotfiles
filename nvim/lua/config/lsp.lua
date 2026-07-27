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

		map("<F2>", vim.lsp.buf.rename, "Rename")
		map("<A-CR>", function()
			vim.lsp.buf.code_action({ context = { only = { "quickfix" } } })
		end, "Code Action")

		map("gd", vim.lsp.buf.definition, "[G]oto [d]efinition")
		map("gD", vim.lsp.buf.hover, "[G]oto [D]ocumentation")
		map("gd", "<Cmd>Telescope lsp_definitions<CR>", "[G]oto [d]efinitions")
		map("gr", "<Cmd>Telescope lsp_references<CR>", "[G]oto [R]eferences")
		map("gi", "<Cmd>Telescope lsp_implementations<CR>", "[G]oto [I]mplementation")
		map("gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "[G]oto [P]review Definition")
		map("<leader>d", vim.diagnostic.open_float, "[D]iagnostic")

		map("<leader>fs", "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "[F]ind [S]ymbols")
	end,
})

local servers = {
	-- clangd = {}, -- C, C++
	-- pyright = {}, -- Python
	-- html = {}, -- HTML
	ts_ls = {}, -- TypeScript & JavaScript
	eslint = {
		settings = {
			nodePath = ".yarn/sdks",
		},
	},
	cssls = {}, -- CSS
	-- tailwindcss = {}, -- Tailwind
	-- jsonls = {}, -- JSON
	-- lemminx = {}, -- XML
	-- yamlls = {}, -- YAML
	-- sqlls = {}, -- SQL
	-- dockerls = {}, -- Docker
	bashls = {}, -- Bash
	lua_ls = { -- Lua
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	},
}

-- setup the servers
for server, config in pairs(servers) do
	vim.lsp.config(server, config)
end

-- Install the servers
require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = vim.tbl_keys(servers),
})

require("lsp-lens").setup({ enable = false })
