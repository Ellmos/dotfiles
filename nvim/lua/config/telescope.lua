require('telescope').setup({ extensions = { ['ui-select'] = { require('telescope.themes').get_dropdown {} } } })
require('telescope').load_extension('ui-select')
require('telescope').load_extension('fzf')

require('telescope').load_extension('projects')

require('telescope').load_extension('yank_history')
