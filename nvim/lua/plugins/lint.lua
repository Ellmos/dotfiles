return {
  "mfussenegger/nvim-lint",
  dependencies = {
    "williamboman/mason.nvim",
    "rshkarin/mason-nvim-lint",
  },
  event = { "BufWritePost", "BufReadPost", "InsertLeave" },
  opts = {
    linters_by_ft = {
      lua = { "luacheck" },
      python = { "ruff" },
      html = { "htmlhint" },
      css = { "stylelint" },
      json = { "jsonlint" },
      dockerfile = { "hadolint" },
      bash = { "shellcheck" },
      go = { "golangcilint" },
    },
  },
  config = function(_, opts)
    local lint = require("lint")
    lint.linters_by_ft = opts.linters_by_ft

    require("mason").setup()
    require("mason-nvim-lint").setup()

    -- Auto-trigger linting on save and buffer changes
    vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged", "InsertLeave" }, {
      callback = function()
        lint.try_lint()
      end,
    })

    vim.api.nvim_create_user_command("LintInfo", function()
      local filetype = vim.bo.filetype
      local linters = require("lint").linters_by_ft[filetype]

      if linters then
        print("Linters for " .. filetype .. ": " .. table.concat(linters, ", "))
      else
        print("No linters configured for filetype: " .. filetype)
      end
    end, {})
  end,
}
