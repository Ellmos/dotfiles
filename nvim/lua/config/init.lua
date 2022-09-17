require("gruvbox").setup({ contrast = "hard" })

require'nvim-web-devicons'.setup{}

require("nvim-tree").setup()
require('telescope').setup{}

require('nvim-autopairs').setup({ disable_filetype = { "TelescopePrompt" , "vim" },})

require("bufferline").setup()
require("lualine").setup({ options = { theme = "nord" }})


require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
    filetype_exclude = { "dashboard" }
}


require("lspsaga").init_lsp_saga()

require'lspconfig'.pyright.setup{}
require('lspkind').init()
require'lspconfig'.pyright.setup{}

require'cmp'.setup({ sources = {{ name = 'buffer' },},})
require'cmp'.setup { sources = {{ name = 'nvim_lsp' }}}
require'cmp'.setup {sources = {{ name = 'path' }}}


local home = os.getenv('HOME')
local db = require('dashboard')
db.preview_command = 'cat | lolcat -F 0.3'
db.preview_file_path = home .. '/.config/nvim/lua/config/startimage.cat'
db.preview_file_height = 11
db.preview_file_width = 70
db.custom_center = {
    {icon = '  ',
    desc = 'Recently latest session                  ',
    shortcut = 'SPC s l',
    action ='SessionLoad'},
    {icon = '  ',
    desc = 'Recently opened files                   ',
    action =  'DashboardFindHistory',
    shortcut = 'SPC f h'},
    {icon = '  ',
    desc = 'Find  File                              ',
    action = 'Telescope find_files find_command=rg,--hidden,--files',
    shortcut = 'SPC f f'},
    {icon = '  ',
    desc ='File Browser                            ',
    action =  'Telescope file_browser',
    shortcut = 'SPC f b'},
    {icon = '  ',
    desc = 'Find  word                              ',
    action = 'Telescope live_grep',
    shortcut = 'SPC f w'},
    {icon = '  ',
    desc = 'Open Personal dotfiles                  ',
    action = 'Telescope dotfiles path=' .. home ..'/.dotfiles',
    shortcut = 'SPC f d'},
}
