return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "antosha417/nvim-lsp-file-operations",
    {
      "rmagatti/goto-preview",
      dependencies = { "rmagatti/logger.nvim" },
      event = "BufEnter",
      config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    },
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
    { "gd", "<Cmd>Telescope lsp_definitions<CR>", desc = "[G]oto [d]efinition" },
    { "gD", vim.lsp.buf.hover, desc = "[G]oto [D]ocumentation" },
    { "gr", "<Cmd>Telescope lsp_references<CR>", desc = "[G]oto [R]eferences" },
    { "gi", "<Cmd>Telescope lsp_implementations<CR>", desc = "[G]oto [I]mplementation" },
    { "gp", "<CMD>lua require('goto-preview').goto_preview_definition()<CR>", desc = "[G]oto [P]review" },
    { "<leader>d", vim.diagnostic.open_float, desc = "[D]iagnostic" },
    { "<leader>fs", "<Cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "[F]ind [S]ymbols" },
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
      lemminx = {}, -- XML
      yamlls = {}, -- YAML
      sqlls = {}, -- SQL
      dockerls = {}, -- Docker
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
