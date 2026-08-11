return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",

    config = function()
      local ts = require("nvim-treesitter")

      local ignore_filetypes = {
        "checkhealth",
        "lazy",
        "mason",
        "dashboard",
        "dashboardpreview",
        "cmp_menu",
        "TelescopePrompt",
        "TelescopeResults",
        "NvimTree",
      }

      local function start(buf, lang)
        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end

        local ok = pcall(vim.treesitter.start, buf, lang)

        if ok then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        desc = "Enable treesitter highlighting and indentation",
        callback = function(event)
          if vim.tbl_contains(ignore_filetypes, event.match) then
            return
          end

          local buf = event.buf
          local lang = vim.treesitter.language.get_lang(event.match) or event.match

          ts.install({ lang }):await(function(err)
            if err then
              vim.notify("Treesitter parser failed: " .. lang, vim.log.levels.WARN)
              return
            end

            start(buf, lang)
          end)
        end,
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true, -- Auto close on trailing </
      },
    },
  },
}
