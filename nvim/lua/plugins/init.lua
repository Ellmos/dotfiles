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

-- https://github.com/folke/noice.nvim
-- https://github.com/rcarriga/nvim-notify
-- https://github.com/anuvyklack/hydra.nvim
return require("lazy").setup({
    -- Global dependencies needed by lots of packages
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-lua/plenary.nvim" },

    -- ColorScheme
    { "ellisonleao/gruvbox.nvim" },

    -- Dashboard
    { "glepnir/dashboard-nvim" },

    -- Project manager
    { "ahmedkhalf/project.nvim" },

    -- Buffers
    { "willothy/nvim-cokeline",                 dependencies = { "stevearc/resession.nvim" } },
    { "nvim-lualine/lualine.nvim" },
    { "famiu/bufdelete.nvim" },
    { "bloznelis/before.nvim" },
    

    -- Highlighting
    { "nvim-treesitter/nvim-treesitter",        build = ":TSUpdate" },

    -- File explorer
    { "nvim-tree/nvim-tree.lua" },
    { "antosha417/nvim-lsp-file-operations" },

    -- Telescope
    { "nvim-telescope/telescope.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
            return vim.fn.executable("make") == 1
        end,
    },

    -- Utils
    { "lukas-reineke/indent-blankline.nvim" },
    { "windwp/nvim-autopairs" },
    { "windwp/nvim-ts-autotag" },
    { "jghauser/mkdir.nvim" },

    -- Yanking
    { "gbprod/yanky.nvim",                  dependencies = { "kkharji/sqlite.lua" } },

    -- Smooth scrolling
    { "declancm/cinnamon.nvim" },

    -- Code folding
    { "jghauser/fold-cycle.nvim" },

    -- Multiline Editing
    { "mg979/vim-visual-multi" },

    -- Comments
    { "folke/todo-comments.nvim" },

    -- Mason
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "jay-babu/mason-null-ls.nvim" },
    { "jay-babu/mason-nvim-dap.nvim",       dependencies = { "nvim-neotest/nvim-nio" } },

    -- LSP
    { "williamboman/nvim-lsp-installer" },
    { "neovim/nvim-lspconfig" },
    { "folke/neodev.nvim" }, -- Specialized in lua lsp for nvim development

    -- Formatting
    { "jose-elias-alvarez/null-ls.nvim" },

    -- Debugger
    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui" },
    { "nvim-telescope/telescope-dap.nvim" },
    { "theHamsta/nvim-dap-virtual-text" },
    { "mfussenegger/nvim-dap-python" },

    -- Completion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
    { "chrisgrieser/cmp-nerdfont" },
    { "petertriho/cmp-git" },
    { "saadparwaiz1/cmp_luasnip" },
    { "chrisgrieser/cmp_yanky" },

    -- Copilot
    { "github/copilot.vim" },

    -- Snippet
    { "L3MON4D3/LuaSnip",                   build = "make install_jsregexp" },

    -- Markdown Preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function(plugin)
            if vim.fn.executable("npx") then
                vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
            else
                vim.cmd([[Lazy load markdown-preview.nvim]])
                vim.fn["mkdp#util#install"]()
            end
        end,
        init = function()
            if vim.fn.executable("npx") then
                vim.g.mkdp_filetypes = { "markdown" }
            end
        end,
    },
    { "brianhuster/live-preview.nvim" },

    -- Typescript
    { "dmmulroy/ts-error-translator.nvim" },
    { "dmmulroy/tsc.nvim" },

    -- Java
    { 'nvim-java/nvim-java' },

    -- Git
    { "lewis6991/gitsigns.nvim" }
})
