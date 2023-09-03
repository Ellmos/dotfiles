local home = os.getenv('HOME')

require('dashboard').setup {
    theme = 'doom',
    config = {
        header = {},
        center = {
            {
                icon = '  ',
                desc = 'Recent Files                          ',
                action = 'Telescope oldfiles',
                key = 'a',
                icon_hl = 'Title',
                desc_hl = 'String',
                key_hl = 'Number',
            },
            {
                icon = '󰥨  ',
                desc = 'Recent Projects                      ',
                action = 'Telescope projects',
                key = 'b',
                icon_hl = 'Title',
                desc_hl = 'String',
                key_hl = 'Number',
            },
            {
                icon = '󰱼  ',
                desc = 'Find  File                            ',
                action = 'Telescope find_files find_command=rg,--hidden,--files',
                key = 'c',
                icon_hl = 'Title',
                desc_hl = 'String',
                key_hl = 'Number',
            },
            {
                icon = '  ',
                desc = 'Find  Word                            ',
                action = 'Telescope live_grep',
                key = 'd',
                icon_hl = 'Title',
                desc_hl = 'String',
                key_hl = 'Number',
            },
            {
                icon = '  ',
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

