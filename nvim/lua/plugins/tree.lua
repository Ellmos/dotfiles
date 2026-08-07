return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
    {
      "s1n7ax/nvim-window-picker",
      opts = {
        hint = "floating-letter",
        selection_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
        picker_config = { handle_mouse_click = true }
      }
    },
	},
  lazy = false,
	keys = {
		{ "<leader><TAB>", "<CMD>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
		{ "<leader>ft", "<CMD>NvimTreeFindFile<CR>", desc = "[F]ind [T]ree" },
	},
	opts = {
		sync_root_with_cwd = true,
		select_prompts = true,
		on_attach = function(bufnr)
			local api = require("nvim-tree.api")
			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end
			api.map.on_attach.default(bufnr)

			vim.keymap.set("n", "<S-CR>", api.tree.change_root_to_node, opts("CD"))
		end,
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
      open_file = {
        window_picker = {
          picker = function() return require("window-picker").pick_window() end
        }
      },
		},
	},
	config = function(_, opts)
    require("nvim-tree").setup(opts)

		local function open_nvim_tree(data)
			local api = require("nvim-tree.api")

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
	end,
}
