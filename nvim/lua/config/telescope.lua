local actions = require("telescope.actions")
local project_actions = require("telescope._extensions.project.actions")

require("telescope").setup({
	defaults = {
		preview = {
			mime_hook = function(filepath, bufnr, opts)
				local is_image = function(filepath)
					local image_extensions = { "png", "jpg" } -- Supported image formats
					local split_path = vim.split(filepath:lower(), ".", { plain = true })
					local extension = split_path[#split_path]
					return vim.tbl_contains(image_extensions, extension)
				end
				if is_image(filepath) then
					local term = vim.api.nvim_open_term(bufnr, {})
					local function send_output(_, data, _)
						for _, d in ipairs(data) do
							vim.api.nvim_chan_send(term, d .. "\r\n")
						end
					end
					vim.fn.jobstart({
						"catimg",
						filepath, -- Terminal image viewer command
					}, { on_stdout = send_output, stdout_buffered = true, pty = true })
				else
					require("telescope.previewers.utils").set_preview_message(
						bufnr,
						opts.winid,
						"Binary cannot be previewed"
					)
				end
			end,
		},
	},
	pickers = {
		find_files = { hidden = true },
		buffers = {
			mappings = {
				n = {
					["<c-w>"] = actions.delete_buffer + actions.move_to_top,
				},
				i = {
					["<c-w>"] = actions.delete_buffer + actions.move_to_top,
				},
			},
		},
		oldfiles = {
			cwd_only = true,
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
		project = {
			display_type = "full",
			base_dirs = {
				"~/Desktop/",
			},
			on_project_selected = function(prompt_bufnr)
				project_actions.change_working_directory(prompt_bufnr, false)

				require("nvim-tree.api").tree.toggle()

				-- close dashboard
				for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
					if vim.bo[bufnr].filetype == "dashboard" then
						vim.api.nvim_buf_delete(bufnr, { force = true })
					end
				end

				vim.cmd("stopinsert")
			end,
		},
	},
})

require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")
require("telescope").load_extension("project")
require("telescope").load_extension("yank_history")
require("telescope").load_extension("before")
require("telescope").load_extension("node-workspace")
