return {
  "gbprod/yanky.nvim",
  dependencies = {
    "kkharji/sqlite.lua",
  },
  opts = {
    ring = { storage = "sqlite" },
    highlight = {
      on_put = false,
      on_yank = false,
    },
  },
  keys = {
    { "y", "<Plug>(YankyYank)", mode = { "n", "v" }, desc = "Yank text" },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "v" }, desc = "Put yanked text after cursor" },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "v" }, desc = "Put yanked text before cursor" },
    { "<A-p>", "<Plug>(YankyPreviousEntry)", mode = { "n", "v" }, desc = "Select previous entry through yank history" },
    { "<A-n>", "<Plug>(YankyNextEntry)", mode = { "n", "v" }, desc = "Select next entry through yank history" },
    { "<leader>p", "<CMD>Telescope yank_history<CR>", mode = { "n", "v" }, desc = "Open Yank History" },
  },
}
