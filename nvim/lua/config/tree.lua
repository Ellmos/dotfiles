local api = require("nvim-tree.api")

local function open_nvim_tree(data)
	-- buffer is not a directory
	if not vim.fn.isdirectory(data.file) == 1 then
		return
	end

	-- if nvim opens on a folder it is doing some weird fuck so kill nvim-tree buffer and reopen
	if string.find(vim.api.nvim_buf_get_name(0), "NvimTree_1") then
		api.tree.close()
		vim.cmd.bw()
		api.tree.open()
	end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

local function my_on_attach(bufnr)
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.map.on_attach.default(bufnr)

	vim.keymap.set("n", "<S-CR>", api.tree.change_root_to_node, opts("CD"))
end

require("nvim-tree").setup({
    sync_root_with_cwd = true,
	on_attach = my_on_attach,
	select_prompts = true,
	view = {
		width = {
			min = 30,
			max = -1,
		},
	},
	actions = {
		change_dir = {
			enable = true,
			global = true,
		},
	},
})

require("lsp-file-operations").setup()
