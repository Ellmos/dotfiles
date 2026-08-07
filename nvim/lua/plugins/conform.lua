return {
  "stevearc/conform.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "zapling/mason-conform.nvim",
  },
  event = { "BufWritePre" },
  cmd = { "ConformInfo", "Format" },
  keys = {
    { "<C-S-s>", "<Cmd>Format<CR><Cmd>w<CR>", mode = { "n", "v", "i" }, desc = "Format current buffer" },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
      html = { "prettier" },
      css = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      bash = { "shfmt" },
      java = { "prettier" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      proto = { "buf" },
      toml = { "taplo" },
    },
    format_on_save = function()
      if vim.g.enable_autoformat then
        return { lsp_format = "fallback" }
      end
    end,
  },
  config = function(_, opts)
    local conform = require("conform")
    conform.setup(opts)

    require("mason").setup()
    require("mason-conform").setup()

    -- Define Format command
    vim.api.nvim_create_user_command("Format", function(opts)
      if opts.args == "enable" then
        vim.g.enable_autoformat = true
      elseif opts.args == "disable" then
        vim.g.enable_autoformat = false
      elseif opts.args == "" then
        conform.format({ lsp_format = "fallback" })
      else
        error("Usage: Format [enable | disable]")
      end
    end, {
    nargs = "?",
    complete = function(_, _, _)
      return { "enable", "disable" }
    end,
  })
end,
}
