-- pov ca mache pas
local disable_function = function()
    local buf_name = vim.fn.expand("%")
    if string.find(buf_name, ".ll") then
        return true
    end
end

require("nvim-treesitter.configs").setup({
    auto_install = true,
    ensure_installed = {
        "c",
        "cpp",
        "python",
        "lua",
        "make",
        "bash",
    },
    sync_install = false,
    indent = { enable = true },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
    disable = disable_function()
})
require('nvim-ts-autotag').setup()
