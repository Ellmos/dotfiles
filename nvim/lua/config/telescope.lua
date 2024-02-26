require('telescope').setup({ 
    extensions = { 
        ['ui-select'] = { require('telescope.themes').get_dropdown() },
        -- fzf = {
        --     fuzzy = true,
        --     override_generic_sorter = true,
        --     override_file_sorter = true,
        --     case_mode = "smart_case",
        -- }
    } 
})
require('telescope').load_extension('ui-select')
-- require('telescope').load_extension('fzf')

require('telescope').load_extension('yank_history')
