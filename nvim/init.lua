require ('plugins')
require ('config')

vim.cmd('filetype plugin indent on')                                                                 
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

map("n", "<leader><Tab>", ":NvimTreeToggle<CR>", opts)
map("n", "<leader>f", ":Telescope find_files<CR>", opts)
