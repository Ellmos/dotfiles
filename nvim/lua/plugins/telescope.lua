local actions = require("telescope.actions")

-- Wraps a sorter factory so index.* files still match normally but always
-- sink to the bottom of the results, instead of floating to the top the way
-- short/common filenames tend to with fuzzy scoring.
local function deprioritize_index_files(base_factory)
  return function(opts)
    local sorter = base_factory(opts)
    local original_scoring_function = sorter.scoring_function

    sorter.scoring_function = function(self, prompt, line, entry, ...)
      local score = original_scoring_function(self, prompt, line, entry, ...)
      if not score or score == -1 then
        return score
      end

      local name = (entry and (entry.filename or entry.value)) or line
      local tail = type(name) == "string" and vim.fn.fnamemodify(name, ":t"):lower() or ""
      local is_index = tail == "index" or tail:match("^index%.")
      local prompt_mentions_index = type(prompt) == "string" and prompt:lower():find("index", 1, true)
      if is_index and not prompt_mentions_index then
        return score + 1000
      end

      return score
    end

    return sorter
  end
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-project.nvim" },
    { "ec965/telescope-node-workspace.nvim" },
  },
  keys = {
    { "<leader>ff", "<Cmd>Telescope find_files<CR>", desc = "[F]ind [F]iles" },
    { "<leader>fo", "<Cmd>Telescope oldfiles<CR>", desc = "[F]ind [O]ld Files" },
    { "<leader>fb", "<Cmd>Telescope buffers<CR>", desc = "[F]ind [B]uffers" },
    { "<leader>fg", "<Cmd>Telescope live_grep<CR>", desc = "[F]ind [G]rep" },
    { "<leader>fw", "<Cmd>Telescope grep_string<CR>", desc = "[F]ind [W]ord" },
    { "<leader>fib", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "[F]ind [I]n [B]uffer" },
    { "<leader>fd", "<Cmd>Telescope diagnostics<CR>", desc = "[F]ind [D]iagnostics" },
    { "<leader>fh", "<Cmd>Telescope help_tags<CR>", desc = "[F]ind [H]elp" },
    { "<leader>fn", "<Cmd>Telescope node-workspace<CR>", desc = "[F]ind [N]ode-workspace" },
    { "<leader>fp", "<Cmd>Telescope project<CR>", desc = "[F]ind [P]roject" },
  },
  opts = {
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
            require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
          end
        end,
      },
    },
    pickers = {
      find_files = { hidden = true },
      buffers = {
        mappings = {
          n = {
            ["<C-w>"] = actions.delete_buffer,
          },
          i = {
            ["<C-w>"] = actions.delete_buffer,
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
          local project_actions = require("telescope._extensions.project.actions")

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
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
    telescope.load_extension("project")
    telescope.load_extension("node-workspace")

    -- fzf-native overwrites file_sorter/generic_sorter when it loads, so
    -- wrap them afterwards to apply to every picker.
    local telescope_config = require("telescope.config").values
    telescope_config.file_sorter = deprioritize_index_files(telescope_config.file_sorter)
    telescope_config.generic_sorter = deprioritize_index_files(telescope_config.generic_sorter)
  end,
}

