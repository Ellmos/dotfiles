local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- https://github.com/folke/noice.nvim
-- https://github.com/rcarriga/nvim-notify
return require('lazy').setup({
    -- ColorScheme
    'ellisonleao/gruvbox.nvim',

    -- Dashboard
    { 'glepnir/dashboard-nvim', dependencies = { 'kyazdani42/nvim-web-devicons' }},

    -- Project manager
    'ahmedkhalf/project.nvim',

    -- Lines
    { 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons' }},
    { 'akinsho/bufferline.nvim', dependencies = { 'kyazdani42/nvim-web-devicons' }},
    { 'famiu/bufdelete.nvim' },

    -- Highlighting
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'lewis6991/spellsitter.nvim',

    -- File explorer
    { 'kyazdani42/nvim-tree.lua', dependencies = { 'kyazdani42/nvim-web-devicons' }, version = 'nightly' },

    -- Telescope
    { 'nvim-telescope/telescope.nvim', version = '0.1.1', dependencies = { 'nvim-lua/plenary.nvim' }},
    'nvim-telescope/telescope-ui-select.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end
    },
    -- Utils
    'lukas-reineke/indent-blankline.nvim',
    'windwp/nvim-autopairs',

    -- Yanking
    { 'gbprod/yanky.nvim', dependencies = { 'kkharji/sqlite.lua' }},
    'chrisgrieser/cmp_yanky',

    -- Smooth scrolling
    'declancm/cinnamon.nvim',

    -- Code folding
    'jghauser/fold-cycle.nvim',

    -- Multiline Editing
    'mg979/vim-visual-multi',

    -- Comments
    'numToStr/Comment.nvim',

    -- Mason
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'jay-babu/mason-null-ls.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- LSP
    'williamboman/nvim-lsp-installer',
    'neovim/nvim-lspconfig',
    'folke/neodev.nvim', -- Specialized in lua lsp for nvim development

    -- Formatting
    { 'jose-elias-alvarez/null-ls.nvim', dependencies = { 'nvim-lua/plenary.nvim' }},

    -- Debugger
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'nvim-telescope/telescope-dap.nvim',
    'theHamsta/nvim-dap-virtual-text',

    -- Completion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'chrisgrieser/cmp-nerdfont',
    { 'petertriho/cmp-git', dependencies = { 'nvim-lua/plenary.nvim' }},
    'saadparwaiz1/cmp_luasnip',

    -- Snippet
    'L3MON4D3/LuaSnip',
})
