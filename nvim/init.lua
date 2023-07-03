vim.g.mapleader = " "

require ('plugins')
require('config')
require('keymaps')

vim.cmd('colorscheme gruvbox')

------------------------General options--------------------------------
local set = vim.opt

set.expandtab = true
set.smarttab = true
set.autoindent = true
set.tabstop = 4
set.shiftwidth = 4
set.foldmethod="indent"
set.foldlevel=1000

set.wrap = false
set.whichwrap:append { ['<'] = true, ['>'] = true, ['['] = true, [']'] = true }
set.scrolloff = 7
set.fileencoding = 'utf-8'
set.termguicolors = true
set.colorcolumn = {80}

set.number = true
set.cursorline = true
set.hidden = true
set.clipboard = 'unnamedplus'
set.filetype.plugin = 'on'

