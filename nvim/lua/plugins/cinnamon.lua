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
    { "<S-j>", function() require("cinnamon").scroll("<C-D>") end, mode = { "n", "v" }, desc = "Scroll cursor down" },
    { "<S-k>", function() require("cinnamon").scroll("<C-U>") end, mode = { "n", "v" }, desc = "Scroll cursor up" },

    { "zz", function() require("cinnamon").scroll("zz") end, mode = { "n", "v" }, desc = "Center window on cursor" },
    { "zj", function() require("cinnamon").scroll("zt") end, mode = { "n", "v" }, desc = "Scroll window down" },
    { "zk", function() require("cinnamon").scroll("zb") end, mode = { "n", "v" }, desc = "Scroll window up" },
    { "zh", function() require("cinnamon").scroll("zH") end, mode = { "n", "v" }, desc = "Scroll window left" },
    { "zl", function() require("cinnamon").scroll("zL") end, mode = { "n", "v" }, desc = "Scroll window right" },
 },
}
