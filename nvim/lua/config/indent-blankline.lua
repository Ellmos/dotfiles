require("ibl").setup {
    exclude = { filetypes = {
        "packer",
        "checkhealth",
        "help",
        "man",
        "gitcommit",
        "TelescopePrompt",
        "TelescopeResults",
        "''",
        "dashboard",
    } },
    scope = { enabled = false }
}
