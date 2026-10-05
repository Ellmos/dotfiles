return {
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "sindrets/diffview.nvim",
      "m00qek/baleia.nvim",
      "nvim-telescope/telescope.nvim", -- optional
    },
    cmd = "Neogit",
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "FabijanZulj/blame.nvim",
    cmd = {
      "BlameToggle",
    },
    opts = {},
  },
}
