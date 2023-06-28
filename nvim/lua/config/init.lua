require('gruvbox').setup({ contrast = 'hard' })

require('bufferline').setup({ })
require('lualine').setup({ options = { theme = 'nord' }})

require('nvim-web-devicons').setup{}
require('telescope').setup{}
require('nvim-autopairs').setup({ disable_filetype = { 'TelescopePrompt' , 'vim' },})
require('gitsigns').setup()

require('config/lsp')
require('config/cmp')
require('config/treesitter')
require('config/tree')
require('config/dashboard')
require('config/neoscroll')
