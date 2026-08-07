return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "antosha417/nvim-lsp-file-operations",
  },
  keys = {
    { "<F2>", vim.lsp.buf.rename, desc = "Rename" },
    {
      "<A-CR>",
      function()
        vim.lsp.buf.code_action({ context = { only = { "quickfix" } } })
      end,
      desc = "Code Action",
    },
    { "gd", vim.lsp.buf.definition, desc = "[G]oto [d]efinition" },
    { "gD", vim.lsp.buf.hover, desc = "[G]oto [D]ocumentation" },
    { "gr", vim.lsp.buf.references, desc = "[G]oto [R]eferences" },
    { "gi", vim.lsp.buf.implementation, desc = "[G]oto [I]mplementation" },
    { "gp", vim.lsp.util.preview_location, desc = "[G]oto [P]review" },
    { "<leader>d", vim.diagnostic.open_float, desc = "[D]iagnostic" },
    { "<leader>fs", vim.lsp.buf.workspace_symbol, desc = "[F]ind [S]ymbols" },
  },
  opts = {
    capabilities = {
      workspace = {
        fileOperations = {
          didRename = true,
          willRename = true,
        },
      },
    },
    servers = {
      clangd = {}, -- C, C++
      ty = {}, -- Python
      html = {}, -- HTML
      ts_ls = {}, -- TypeScript & JavaScript
      eslint = {
        settings = {
          nodePath = ".yarn/sdks",
        },
      },
      cssls = {}, -- CSS
      jsonls = {}, -- JSON
      jdtls = {}, -- Java
      lemminx = {}, -- XML
      yamlls = {}, -- YAML
      sqlls = {}, -- SQL
      dockerls = {}, -- Docker
      golangci_lint_ls = {}, -- Go
      bashls = { -- Bash
        default_config = {
          cmd = { "bash-language-server", "start" },
          filetypes = { "sh" },
        },
      },
      lua_ls = { -- Lua
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    for server, config in pairs(opts.servers) do
      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(opts.servers),
    })
  end,
}
