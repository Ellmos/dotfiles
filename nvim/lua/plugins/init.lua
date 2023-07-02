return require('packer').startup(function(use)
	-- Packer can manage itself
	use { 'wbthomason/packer.nvim' }

	-- ColorScheme
	use { 'ellisonleao/gruvbox.nvim' }

	-- Dashboard
	use { 'glepnir/dashboard-nvim', requires = { 'kyazdani42/nvim-web-devicons' }}

	-- Project manager
	use { 'ahmedkhalf/project.nvim' }

	-- Lines
	use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' }}
	use { 'akinsho/bufferline.nvim', requires = { 'kyazdani42/nvim-web-devicons' }, tag = 'v2.*' }

	-- Highlighting
	use { 'nvim-treesitter/nvim-treesitter', commit = 'd47f3469e3a783e7d1382ab3fe95ba2fa3021ec0', build = ':TSUpdate' }

	-- File explorer
	use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' }, tag = 'nightly' }

	-- Fuzzy finding tool
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.1', requires = { 'nvim-lua/plenary.nvim' }}
	use { 'nvim-telescope/telescope-ui-select.nvim' }
	use { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make',
	cond = function()
		return vim.fn.executable 'make' == 1
	end}

	-- Utils
	use { 'lewis6991/gitsigns.nvim' }
	use { 'lukas-reineke/indent-blankline.nvim' }
	use { 'windwp/nvim-autopairs' }

	-- Smooth scrolling
	use { 'declancm/cinnamon.nvim' }

	-- Code folding
	use { 'jghauser/fold-cycle.nvim' }

	-- Comments
	use { 'numToStr/Comment.nvim' }

	-- LSP
	use { 'williamboman/nvim-lsp-installer' }
	use { 'neovim/nvim-lspconfig' }
	use { 'williamboman/mason.nvim' }
	use { 'williamboman/mason-lspconfig.nvim' }
	use { 'folke/neodev.nvim'}


	-- Completion
	use { 'hrsh7th/nvim-cmp' }
	use { 'hrsh7th/cmp-nvim-lsp'}
	use { 'hrsh7th/cmp-buffer'}
	use { 'hrsh7th/cmp-path'}
	use { 'hrsh7th/cmp-cmdline' }
    use {"petertriho/cmp-git", requires = "nvim-lua/plenary.nvim"}

	-- Snippet
	use { 'L3MON4D3/LuaSnip' }
	use { 'saadparwaiz1/cmp_luasnip' }
end)
