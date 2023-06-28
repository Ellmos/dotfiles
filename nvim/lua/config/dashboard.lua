require("indent_blankline").setup {
    filetype_exclude = { "dashboard" }
}

--------------------------------Dashboard-------------------------------
local home = os.getenv('HOME')
local db = require('dashboard')

db.preview_command = 'cat | lolcat -F 0.3'
db.preview_file_path = home .. '/.config/nvim/lua/config/startimage.cat'
db.preview_file_height = 11
db.preview_file_width = 70

db.custom_center = {
    {icon = '  ',
    desc = 'Recently latest session               ',
    shortcut = 'SPC l',
    action = 'SessionLoad'},

    {icon = '  ',
    desc = 'Find  File                            ',
    action = 'Telescope find_files find_command=rg,--hidden,--files',
    shortcut = 'SPC f'},

    {icon = '  ',
    desc = 'Find  word                            ',
    action = 'Telescope live_grep',
    shortcut = 'SPC d'},

    {icon = '  ',
    desc = 'Edit Dotfiles                         ',
    action = ':e /home/elmos/Documents/dotfiles/',
    shortcut = 'SPC e'},
}

