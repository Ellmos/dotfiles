require('gruvbox').setup({ contrast = 'hard' })

require('bufferline').setup()
require('lualine').setup({ options = { theme = 'nord' }})

require('nvim-web-devicons').setup()
require('nvim-autopairs').setup({ disable_filetype = { 'TelescopePrompt' , 'vim' }})
require('gitsigns').setup()
require('indent_blankline').setup({ filetype_exclude = { 'dashboard' }})

require('project_nvim').setup()
require("telescope").setup({ extensions = { ["ui-select"] = { require("telescope.themes").get_dropdown{}}} })
require("telescope").load_extension("ui-select")
require('telescope').load_extension('projects')


require('config/lsp')
require('config/cmp')
require('config/treesitter')
require('config/tree')
require('config/dashboard')
require('config/neoscroll')
