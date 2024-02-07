require('nvim-treesitter.configs').setup({
    auto_install = true,
    ensure_installed = {
        'c',
        'cpp',
        'c_sharp',
        'python',
        'lua',
        'make',
        'javascript',
        'markdown',
        'bash'
    },
    sync_install = false,
    indent = { enable = true },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    -- rainbow = {
    --     enable = true,
    --     extended_mode = true,
    --     max_file_lines = nil,
    -- },
})
