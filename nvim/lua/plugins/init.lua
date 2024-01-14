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

    -- File explorer
    { 'kyazdani42/nvim-tree.lua', dependencies = { 'kyazdani42/nvim-web-devicons' }, version = 'nightly' },

    -- Fuzzy finding tool
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
    {
        'gbprod/yanky.nvim',
        dependencies = { 'kkharji/sqlite.lua'},
        config = function()
            require('yanky').setup({
                highlight = {
                    on_put = false,
                    on_yank = false,
                },
                opts = {
                    ring = { storage = 'sqlite' },
                },
            })
        end,
        highlight = {
            on_put = false,
            on_yank = false,
        },
        keys = {
            { '<leader>p', function() require('telescope').extensions.yank_history.yank_history({ }) end, desc = 'Open Yank History' },
            { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yank text' },
            { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after cursor' },
            { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before cursor' },
            { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
            { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
        }
    },
    'chrisgrieser/cmp_yanky',

    -- Smooth scrolling
    'declancm/cinnamon.nvim',

    -- Code folding
    'jghauser/fold-cycle.nvim',

    -- Multiline Editing
    'mg979/vim-visual-multi',

    -- Comments
    'numToStr/Comment.nvim',

    -- LSP
    'williamboman/nvim-lsp-installer',
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
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

    -- Debugger
    'mfussenegger/nvim-dap',
})
