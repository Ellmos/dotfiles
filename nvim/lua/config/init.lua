-- Theme
require("gruvbox").setup({
    contrast = "medium",
    overrides = {
        TabLineFill = { bg = "#181919" },
        SignColumn = { bg = "#181919" },
        DiagnosticSignError = { bg = "#181919" },
        DiagnosticSignWarn = { bg = "#181919" },
        DiagnosticSignInfo = { bg = "#181919" },
        DiagnosticSignHint = { bg = "#181919" }
    }
})

-- Dependecies
require("nvim-web-devicons").setup()

-- buffers
require("lualine").setup({ options = { theme = "nord" } })
require("before").setup({ history_size = 100 })

-- Project
require("project_nvim").setup({ patterns = { ".git", "*.sln" } })

-- Higlight TODO / FIXME ...
require("todo-comments").setup()

-- Code folding
require("fold-cycle").setup({ open_if_max_closed = false, close_if_max_opened = false })

-- Autocomplete pairs (brackets, quotes....)
require("nvim-autopairs").setup({ disable_filetype = { "TelescopePrompt", "vim" } })

-- Typescript shit
require("ts-error-translator").setup()
require('tsc').setup()

-- Java shit
require('java').setup()

-- Git
require('gitsigns').setup()

-- Other config file
require("config/tree")
require("config/cokeline")
require("config/yanky")
require("config/null_ls")
require("config/cmp")
require("config/lsp")
require("config/treesitter")
require("config/dashboard")
require("config/indent-blankline")
require("config/dap")
require("config/telescope")
require("config/cinnamon")
