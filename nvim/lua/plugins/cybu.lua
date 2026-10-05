local function set_transparent_border()
  local float_border = vim.api.nvim_get_hl(0, { name = "FloatBorder", link = false })
  vim.api.nvim_set_hl(0, "CybuBorder", { fg = float_border.fg, bg = "NONE" })
end

return {
  "ghillb/cybu.nvim",
  branch = "main",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  opts = {
    style = {
      border = "rounded",
    },
    exclude = { "NvimTree", "toggleterm", "qf" },
    -- how long (ms) cybu waits after the last <C-Tab> press before switching:
    -- a quick single tap feels immediate, repeated taps while holding ctrl
    -- keep resetting this timer, mimicking a "release to select" popup.
    display_time = 300,
  },
  config = function(_, opts)
    require("cybu").setup(opts)
    set_transparent_border()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_transparent_border })
  end,
  keys = {
    { "<C-Tab>", "<Plug>(CybuLastusedNext)", mode = "n", desc = "Cycle to next buffer (MRU)" },
    { "<C-S-Tab>", "<Plug>(CybuLastusedPrev)", mode = "n", desc = "Cycle to previous buffer (MRU)" },
  },
}
