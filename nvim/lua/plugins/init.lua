vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim'}

    --ColorScheme
    use {
        'ellisonleao/gruvbox.nvim',
        commit = 'cb7a8a867cfaa7f0e8ded57eb931da88635e7007'
    }

    --Dashboard
    use {'glepnir/dashboard-nvim'}
    use("lewis6991/gitsigns.nvim")


    --DevIcons
    use { 'kyazdani42/nvim-web-devicons' }

    -- Highlights
    use { 
        'nvim-treesitter/nvim-treesitter',
        commit = 'd47f3469e3a783e7d1382ab3fe95ba2fa3021ec0'
    }

    --ToolBars
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

    --NvimTree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons',}, tag = 'nightly' 
    }

    --Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    --LSP
    use {
        "williamboman/nvim-lsp-installer",
        "neovim/nvim-lspconfig",
    }
    use {"hrsh7th/cmp-nvim-lsp"}
    use {"hrsh7th/cmp-buffer"}
    use {"hrsh7th/cmp-path"}
    use {"hrsh7th/cmp-cmdline"}
    use {"hrsh7th/nvim-cmp"}

    use {"onsails/lspkind-nvim"}
    use {"glepnir/lspsaga.nvim"}

    use {"L3MON4D3/LuaSnip"}
    use { 'saadparwaiz1/cmp_luasnip' }

    use {'MunifTanjim/prettier.nvim'}

    --BlankLine
    use { "lukas-reineke/indent-blankline.nvim" }

    --AutoPairs
    use { "windwp/nvim-autopairs" }
end)
