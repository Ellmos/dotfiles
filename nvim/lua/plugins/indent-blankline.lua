return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    exclude = {
      filetypes = {
        "packer",
        "checkhealth",
        "help",
        "man",
        "gitcommit",
        "TelescopePrompt",
        "TelescopeResults",
        "''",
        "dashboard",
      },
    },
    scope = { enabled = false },
  },
  config = function(_, opts)
    require("ibl").setup(opts)

    -- ibl wraps the inlayHint handler with a 3-param function (err, result, ctx).
    -- goto-preview picks its handler signature from the first textDocument/* handler
    -- found via pairs() (random order): if it hits this one, it uses its legacy
    -- handler, gets a nil result and `gp` silently does nothing.
    -- Re-wrap it with the 4-param signature so goto-preview always picks the right one.
    local inlay_hint_handler = vim.lsp.handlers["textDocument/inlayHint"]
    vim.lsp.handlers["textDocument/inlayHint"] = function(err, result, ctx, config)
      return inlay_hint_handler(err, result, ctx, config)
    end
  end,
}
