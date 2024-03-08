local set = vim.opt

set.expandtab = true
set.smarttab = true
set.cindent = true
set.tabstop = 4
set.shiftwidth = 4
set.foldmethod = "indent"
set.foldlevel = 1000

set.wrap = false
set.whichwrap:append({ ["<"] = true, [">"] = true, ["["] = true, ["]"] = true })
set.scrolloff = 7
set.modifiable = true
set.fileencoding = "utf-8"
set.termguicolors = true
set.colorcolumn = { 80 }

set.number = true
set.cursorline = true
set.hidden = true
set.clipboard = "unnamedplus"
set.filetype.plugin = "on"

-- for nvim-tree
local g = vim.g
g.loaded_netrw = true
g.loaded_netrwPlugin = true

vim.cmd("set list listchars=tab:»·,trail:·,eol:$")

require("plugins")
require("keymaps")
require("config")

vim.cmd("colorscheme gruvbox")
