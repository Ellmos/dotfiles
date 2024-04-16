-- Theme
require("gruvbox").setup({ contrast = "medium" })

-- Lines
require("lualine").setup({ options = { theme = "nord" } })
require("bufferline").setup()

-- Project
require("project_nvim").setup({ patterns = { ".git", "*.sln" } })

-- Code commenting
require("Comment").setup()

-- Smooth scroll
require("cinnamon").setup({ default_delay = 7, override_keymaps = true })

-- Autocomplete pairs (brackets, quotes....)
require("nvim-autopairs").setup({ disable_filetype = { "TelescopePrompt", "vim" } })

-- Dependecies
require("nvim-web-devicons").setup()

-- Other config file
require("config/tree")
require("config/yanky")
-- require("config/null_ls")
require("config/cmp")
require("config/lsp")
require("config/treesitter")
require("config/indent-blankline")
--require("config/dap")
require("config/telescope")
