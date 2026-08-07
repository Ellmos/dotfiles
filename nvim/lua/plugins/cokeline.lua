return {
  "willothy/nvim-cokeline",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  opts = function()
    local get_hex = require("cokeline.hlgroups").get_hl_attr

    return {
      history = {
        enabled = true,
        size = 100,
      },

      sidebar = {
        filetype = { "NvimTree" },
        components = {
          {
            text = function(buf)
              return buf.filetype
            end,
            bold = true,
          },
        },
      },

      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
        end,
        bg = "NONE",
      },

      components = {
        {
          text = function(buffer)
            return buffer.index ~= 1 and " ▏" or ""
          end,
          fg = function()
            return get_hex("Normal", "fg")
          end,
        },
        {
          text = function(buffer)
            return " " .. buffer.devicon.icon
          end,
          fg = function(buffer)
            return buffer.devicon.color
          end,
        },
        {
          text = function(buffer)
            return buffer.unique_prefix
          end,
          bold = function(buffer)
            return buffer.is_focused
          end,
          italic = true,
        },
        {
          text = function(buffer)
            return buffer.filename .. " "
          end,
          bold = function(buffer)
            return buffer.is_focused
          end,
        },
        {
          text = function(buffer)
            return buffer.is_modified and "" or "󰖭"
          end,
          on_click = function(_, _, _, _, buffer)
            if not buffer.is_modified then
              buffer:delete()
            end
          end,
          bold = function(buffer)
            return buffer.is_focused
          end,
          fg = function(buffer)
            return buffer.is_modified and "#00FFFF" or get_hex("Normal", "fg")
          end,
        },
        {
          text = " ",
        },
      },
    }
  end,
  keys = {
    { "<TAB>", "<Plug>(cokeline-focus-next)", desc = "Move to next buffer" },
    { "<S-TAB>", "<Plug>(cokeline-focus-prev)", desc = "Move to previous buffer" },
    {
      "<C-TAB>",
      function()
        require("cokeline.history"):last():focus()
      end,
      desc = "Move to previous buffer",
    },
  },
}
