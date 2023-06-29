require("indent_blankline").setup {
    filetype_exclude = { "dashboard" }
}
----------------------------------Dashboard-------------------------------

local home = os.getenv('HOME')

require('dashboard').setup {
    theme = 'doom',
    config = {
        header = {},
        center = {
            {
                icon = '  ',
                desc = 'Recently latest session               ',
                action = 'Leaderf mru --popup',
                key = 'l',
                icon_hl = 'Title',
                desc_hl = 'String',
                key_hl = 'Number',
            },
            {
                icon = '  ',
                desc = 'Find  File                            ',
                action = 'Telescope find_files find_command=rg,--hidden,--files',
                key = 'f',
                icon_hl = 'Title',
                desc_hl = 'String',
                key_hl = 'Number',
            },
            {
                icon = '  ',
                desc = 'Find  word                            ',
                action = 'Telescope live_grep',
                key = 'w',
                icon_hl = 'Title',
                desc_hl = 'String',
                key_hl = 'Number',
            },
            {
                icon = '  ',
                desc = 'Edit Dotfiles                         ',
                action = ':e /home/elmos/Documents/dotfiles/',
                key = 'e',
                icon_hl = 'Title',
                desc_hl = 'String',
                key_hl = 'Number',
            },
        }
    },
    preview = {
        command = 'cat | lolcat -F 0.3',
        file_path = home .. '/.config/nvim/lua/config/startimage.cat',
        file_height = 13,
        file_width = 70,
    },
}

