-- Theme
require('gruvbox').setup({ contrast = 'medium' })

-- Lines
require('lualine').setup({ options = { theme = 'nord' }})
require('bufferline').setup({ highlights = {fill = { bg='#181818' }} }) -- probem with bg of line so manually set to gruvbox

-- Indentation visualisation
require("ibl").setup { scope = { enabled = false } }

-- Code commenting
require('Comment').setup()

-- Smooth scroll
require('cinnamon').setup({ default_delay = 10, override_keymaps = true })

-- Code folding
require('fold-cycle').setup({ open_if_max_closed = false, close_if_max_opened = false })

-- Autocomplete pairs (brackets, quotes....)
require('nvim-autopairs').setup({ disable_filetype = { 'TelescopePrompt' , 'vim' }})

-- Dependecies
require('nvim-web-devicons').setup()
require('gitsigns').setup()

-- Other config file
require('config/cmp')
require('config/lsp')
require('config/treesitter')
require('config/tree')
require('config/dashboard')
require('config/telescope')
