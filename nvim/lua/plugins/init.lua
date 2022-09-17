return require('packer').startup(function(use)
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim'}

    --ColorScheme
    use { "ellisonleao/gruvbox.nvim" }

    --DevIcons
    use { 'kyazdani42/nvim-web-devicons' }

    --Ouaip ce package est partout mais je sais pas a quoi il sert xD
    use { 'nvim-treesitter/nvim-treesitter', run = "TSUpdate" }

    --ToolBars
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
    use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}

    --NvimTree
    use {
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons', },
      tag = 'nightly' 
    }

    --Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    --LSP
    use { "onsails/lspkind-nvim" }
    use {"hrsh7th/cmp-buffer"}
    use {"hrsh7th/cmp-path"}
	use {"hrsh7th/cmp-nvim-lsp"}
	use {"hrsh7th/nvim-cmp"}
    use {"neovim/nvim-lspconfig"}
	use {"glepnir/lspsaga.nvim"}
	use {"L3MON4D3/LuaSnip"}
	use {"simrat39/rust-tools.nvim"}

    --BlankLine
    use { "lukas-reineke/indent-blankline.nvim" }

    --AutoPairs
    use { "windwp/nvim-autopairs" }
end)
