vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim'}

    --ColorScheme
    use { "ellisonleao/gruvbox.nvim" }

    --Dashboard
    use {'glepnir/dashboard-nvim'}
    use("lewis6991/gitsigns.nvim")


    --DevIcons
    use { 'kyazdani42/nvim-web-devicons' }

    --Ouaip ce package est partout mais je sais pas a quoi il sert xD
    use { 'nvim-treesitter/nvim-treesitter', run = ":TSUpdate" }

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
    use {"neovim/nvim-lspconfig"}
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
