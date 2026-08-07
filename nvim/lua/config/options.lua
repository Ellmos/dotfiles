local set = vim.opt

set.expandtab = true
set.smarttab = true
set.cindent = true
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.foldmethod = "indent"
set.foldlevel = 1000

set.wrap = false
set.whichwrap:append({ ["<"] = true, [">"] = true, ["["] = true, ["]"] = true })
set.scrolloff = 7
set.modifiable = true
set.fileencoding = "utf-8"
set.termguicolors = true
set.colorcolumn = { 120 }

set.number = true
set.cursorline = true
set.hidden = true
set.clipboard = "unnamedplus"
set.filetype.plugin = "on"

set.splitright = true
set.splitbelow = true

vim.diagnostic.config({ virtual_text = true })

-- Disable netrw to let nvim-tree handle file browsing
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
