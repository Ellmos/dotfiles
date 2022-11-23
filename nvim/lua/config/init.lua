require("gruvbox").setup({ contrast = "hard" })

require'nvim-web-devicons'.setup{}

require('telescope').setup{}


require("bufferline").setup({ })

require("lualine").setup({ options = { theme = "nord" }})


require("lspsaga").init_lsp_saga()
require('lspkind').init()




--------------------------------Prettier-----------------------------
local prettier = require("prettier")

prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.22+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
    "python",
  },
})
