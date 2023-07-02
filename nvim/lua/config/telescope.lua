require('project_nvim').setup({ manual_mode = true })

require("telescope").setup({ extensions = { ["ui-select"] = { require("telescope.themes").get_dropdown{}}} })
require("telescope").load_extension("ui-select")
require('telescope').load_extension('projects')
pcall(require('telescope').load_extension, 'fzf')

