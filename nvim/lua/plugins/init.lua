return require('packer').startup(function(use)
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim' }

    -- ColorScheme
    use { 'ellisonleao/gruvbox.nvim', commit = 'cb7a8a867cfaa7f0e8ded57eb931da88635e7007' }

    -- Dashboard
    use { 'glepnir/dashboard-nvim' }
    use { 'lewis6991/gitsigns.nvim' }

    -- Lines
    use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }
    use { 'akinsho/bufferline.nvim', requires = { 'kyazdani42/nvim-web-devicons' }, tag = 'v2.*' }

    -- Useful
    use { 'nvim-treesitter/nvim-treesitter', commit = 'd47f3469e3a783e7d1382ab3fe95ba2fa3021ec0' }
    use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' }, tag = 'nightly' }
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.1', requires = {{ 'nvim-lua/plenary.nvim' }}}
    use { 'lukas-reineke/indent-blankline.nvim' }
    use { 'windwp/nvim-autopairs' }
    use { 'preservim/nerdcommenter' }
    use { 'karb94/neoscroll.nvim' }

    --LSP
    use { 'williamboman/nvim-lsp-installer' }
    use { 'neovim/nvim-lspconfig' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/nvim-cmp' }

    --Snippet
    use { 'L3MON4D3/LuaSnip' }
    use { 'saadparwaiz1/cmp_luasnip' }
end)
