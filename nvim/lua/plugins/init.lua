local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
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
    { 'famiu/bufdelete.nvim' },

    -- Highlighting
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'HiPhish/nvim-ts-rainbow2' },

    -- File explorer
    { 'kyazdani42/nvim-tree.lua', dependencies = { 'kyazdani42/nvim-web-devicons' }, version = 'nightly' },

    -- Telescope
    { 
        'nvim-telescope/telescope.nvim', 
        dependencies = { 
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end,
        }
    },
    -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    -- Utils
    'lukas-reineke/indent-blankline.nvim',
    'windwp/nvim-autopairs',

    -- Yanking
    { 'gbprod/yanky.nvim', dependencies = { 'kkharji/sqlite.lua' }},
    'chrisgrieser/cmp_yanky',

    -- Smooth scrolling
    'declancm/cinnamon.nvim',

    -- Multiline Editing
    'mg979/vim-visual-multi',

    -- Comments
    'numToStr/Comment.nvim',

    -- LSP
    'williamboman/nvim-lsp-installer',
    'neovim/nvim-lspconfig',
    -- 'williamboman/mason.nvim',
    -- 'williamboman/mason-lspconfig.nvim',
    'folke/neodev.nvim',

    -- Completion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'chrisgrieser/cmp-nerdfont',
    { 'petertriho/cmp-git', dependencies = { 'nvim-lua/plenary.nvim' }},

    -- Snippet
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
})
