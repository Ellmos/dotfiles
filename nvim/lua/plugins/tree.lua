return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  keys = {
    { "<leader><TAB>", "<CMD>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
    { "<leader>ft", "<CMD>NvimTreeFindFile<CR>", desc = "[F]ind [T]ree" },
  },
  init = function()
    -- Disable netrw to let nvim-tree handle file browsing
    vim.g.loaded_netrw = true
    vim.g.loaded_netrwPlugin = true
  end,
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
    },
  },
}
