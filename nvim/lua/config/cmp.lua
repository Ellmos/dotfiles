vim.cmd([[
set completeopt=menuone,noinsert,noselect,popup
highlight! default link CmpItemKind CmpItemMenuDefault
]])

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")

require("luasnip.loaders.from_vscode").load()

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.mapping.scroll_docs(-4)
			elseif vim.fn["copilot#GetDisplayedSuggestion"]().text ~= "" then
				vim.api.nvim_feedkeys(vim.fn["copilot#Previous"](), "n", true)
			else
				fallback()
			end
		end, { "i", "c" }),
		["<C-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.mapping.scroll_docs(4)
			elseif vim.fn["copilot#GetDisplayedSuggestion"]().text ~= "" then
				vim.api.nvim_feedkeys(vim.fn["copilot#Next"](), "n", true)
			else
				fallback()
			end
		end, { "i", "c" }),
		["<C-e>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.close()
			elseif vim.fn["copilot#GetDisplayedSuggestion"]().text ~= "" then
				vim.api.nvim_feedkeys(vim.fn["copilot#Dismiss"](), "n", true)
			else
				fallback()
			end
		end),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif vim.fn["copilot#GetDisplayedSuggestion"]().text ~= "" then
				vim.api.nvim_feedkeys(vim.fn["copilot#Accept"](), "n", true)
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "nerdfont" },
		{ name = "git" },
		-- { name = "cmdline" },
		-- { name = "cmp_yanky" },
	},
	formatting = {
		format = function(entry, vim_item)
			local icons = {
				Text = "󰗴 ",
				Method = " ",
				Function = "󰊕 ",
				Constructor = " ",
				Field = " ",
				Variable = "󰬟 ",
				Class = " ",
				Interface = " ",
				Module = " ",
				Property = " ",
				Unit = " ",
				Value = " ",
				Enum = " ",
				Keyword = " ",
				Snippet = " ",
				Color = " ",
				File = " ",
				Reference = "",
				Folder = " ",
				EnumMember = " ",
				Constant = " ",
				Struct = " ",
				Event = " ",
				Operator = " ",
				TypeParameter = " ",
			}
			vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				buffer = "[BUF]",
				luasnip = "[Snip]",
			})[entry.source.name]

			return vim_item
		end,
	},
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

require("cmp_git").setup()
