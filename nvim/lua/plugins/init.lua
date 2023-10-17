return require('packer').startup(function(use)
	-- Packer can manage itself
	use { 'wbthomason/packer.nvim' }

	-- ColorScheme
	use { 'ellisonleao/gruvbox.nvim' }

	-- Lines
	use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' }}
	use { 'akinsho/bufferline.nvim', requires = { 'kyazdani42/nvim-web-devicons' }, tag = '*' }

	-- Highlighting
	use { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' }

	-- File explorer
	use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' }, tag = 'nightly' }

	-- Telescope
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.3', requires = { 'nvim-lua/plenary.nvim' }}

	-- Utils
	use { 'lewis6991/gitsigns.nvim' }
	use { 'lukas-reineke/indent-blankline.nvim' }
	use { 'windwp/nvim-autopairs' }

	-- Smooth scrolling
	use { 'declancm/cinnamon.nvim' }

    -- Multiline Editing
    use { 'mg979/vim-visual-multi' }

	-- Comments
	use { 'numToStr/Comment.nvim' }

	-- LSP
	use { 'neovim/nvim-lspconfig' }

	-- Completion
	use { 'hrsh7th/nvim-cmp' }
	use { 'hrsh7th/cmp-nvim-lsp'}
	use { 'hrsh7th/cmp-buffer'}
	use { 'hrsh7th/cmp-path'}
    use { 'chrisgrieser/cmp-nerdfont' }

	-- Snippet
	use { 'L3MON4D3/LuaSnip' }
	use { 'saadparwaiz1/cmp_luasnip' }
end)
