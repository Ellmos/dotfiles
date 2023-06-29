require ('plugins')
require('config')

vim.cmd('colorscheme gruvbox')

------------------------General options--------------------------------
local set = vim.opt
local let = vim.g

set.expandtab = true
set.smarttab = true
set.shiftwidth = 4
set.tabstop = 4

set.wrap = false
set.scrolloff = 10
set.fileencoding = 'utf-8'
set.termguicolors = true
set.colorcolumn = {80}

set.number = true
set.cursorline = true
set.hidden = true
set.clipboard = 'unnamedplus'
set.filetype.plugin = 'on'

--------------------------Keympas--------------------------
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
let.mapleader = " "

--Move through different buffers
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-w>', ':bd<CR>', opts)

--Switch windows
map('n', '<TAB>', ':BufferLineCycleNext<CR>', opts)
map('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', opts)

--Move lines with alt key
map('n', '<A-j>', ':m +1<CR>==', opts)
map('n', '<A-k>', ':m -2<CR>==', opts)

map('v', '<A-j>', ':m \'>+1<CR>gv=gv', opts)
map('v', '<A-k>', ':m \'<-2<CR>gv=gv', opts)

--Fast scroll
map('n', '<S-l>', 'zL', opts)
map('n', '<S-h>', 'zH', opts)

--Telescope and NvimTree shortcut
map('n', '<leader><Tab>', ':NvimTreeToggle<CR>', opts)
map('n', '<leader>f', ':Telescope find_files<CR>', opts)
map('n', '<leader>d', ':Telescope live_grep<CR>', opts)

--Some cool random stuff
map('n', '<leader>;', '<s-a>;<ESC>', opts)
map('n', '<leader>,', '<s-a>,<ESC>', opts)
map('n', 'µ', ':noh<CR>', opts)
