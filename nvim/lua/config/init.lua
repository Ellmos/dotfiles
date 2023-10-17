-- Theme
require('gruvbox').setup({ contrast = 'medium' })

-- Lines
require('lualine').setup({ options = { theme = 'nord' }})
require("bufferline").setup()

-- Indentation visualisation
require("ibl").setup { scope = { enabled = false } }

-- Code commenting
require('Comment').setup()

-- Smooth scroll
require('cinnamon').setup({ default_delay = 10, override_keymaps = true })

-- Autocomplete pairs (brackets, quotes....)
require('nvim-autopairs').setup({ disable_filetype = { 'TelescopePrompt' , 'vim' }})

-- Dependecies
require('nvim-web-devicons').setup()
require('gitsigns').setup()


require('telescope').setup()

-- Other config file
require('config/cmp')
require('config/lsp')
require('config/treesitter')
require('config/tree')
