require("config.options")
require("config.keymaps")
require("config.lazy")
require("config.autocmds")

-- order important: load plugins, call setup() on all of them, then setup all the keymaps
-- require("plugins")
-- require("config")
-- require("keymaps")

vim.cmd("colorscheme gruvbox")
