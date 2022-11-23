require ('plugins')

require('config')
require('config/lsp')
require('config/tree')
require('config/dashboard')
require('config/treesitter')

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

--------------------------Keympas-------------------------------------
let.mapleader = " "
local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

--Move trhough different buffer
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map("n", "<C-w>", ":bd<CR>", opts)

--Ouais t'as capte ce qui se passe la fait pas chier
map('n', '<TAB>', ':BufferLineCycleNext<CR>', opts)
map('n', '<s-TAB>', ':BufferLineCyclePrev<CR>', opts)


--Move Lines
map('n', '<A-j>', ':m +1<CR>==', opts)
map('n', '<A-k>', ':m -2<CR>==', opts)

map('v', '<A-j>', ':m \'>+1<CR>gv=gv', opts)
map('v', '<A-k>', ':m \'<-2<CR>gv=gv', opts)



--La aussi casse pas les couilles
map("n", "<leader><Tab>", ":NvimTreeToggle<CR>", opts)
map("n", "<leader>f", ":Telescope find_files<CR>", opts)
map("n", "<leader>d", ":Telescope live_grep<CR>", opts)

map("n", "<leader>;", "<s-a>;<ESC>", opts)
map("n", "<leader>,", "<s-a>,<ESC>", opts)
map("n", "<s-l>", ":noh<CR>", opts);
