local function scroll(key)
  return function()
    require("cinnamon").scroll(key)
  end
end

return {
  "declancm/cinnamon.nvim",
  opts = {
    keymaps = {
      basic = false,
      extra = false,
    },
    options = {
      delay = 4,
    },
  },
  keys = {
    { "<S-j>", scroll("<C-D>"), mode = { "n", "v" }, desc = "Scroll cursor down" },
    { "<S-k>", scroll("<C-U>"), mode = { "n", "v" }, desc = "Scroll cursor up" },
    { "zz", scroll("zz"), mode = { "n", "v" }, desc = "Center window on cursor" },
    { "zj", scroll("zt"), mode = { "n", "v" }, desc = "Scroll window down" },
    { "zk", scroll("zb"), mode = { "n", "v" }, desc = "Scroll window up" },
    { "zh", scroll("zH"), mode = { "n", "v" }, desc = "Scroll window left" },
    { "zl", scroll("zL"), mode = { "n", "v" }, desc = "Scroll window right" },
  },
}
