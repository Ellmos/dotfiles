local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

return require('lazy').setup({
    -- ColorScheme
    'ellisonleao/gruvbox.nvim',

    -- Lines
    { 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons' }},
    { 'akinsho/bufferline.nvim', dependencies = { 'kyazdani42/nvim-web-devicons' }, version = '*' },

    -- Highlighting
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },


    -- File explorer
    { 'kyazdani42/nvim-tree.lua', dependencies = { 'kyazdani42/nvim-web-devicons' }, version = 'nightly' },

    -- Telescope
    { 'nvim-telescope/telescope.nvim', version = '0.1.3', dependencies = { 'nvim-lua/plenary.nvim' }},
    'nvim-telescope/telescope-ui-select.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end
    },

    -- Utils
    'lukas-reineke/indent-blankline.nvim',
    'windwp/nvim-autopairs',

    -- Smooth scrolling
    'declancm/cinnamon.nvim',

    -- Multiline Editing
    'mg979/vim-visual-multi',

    -- Comments
    'numToStr/Comment.nvim',

    -- LSP
    'neovim/nvim-lspconfig',

    -- Completion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'chrisgrieser/cmp-nerdfont',

    -- Snippet
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
})
