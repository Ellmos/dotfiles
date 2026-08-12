local function get_buffer_state(buffer)
  if buffer.is_focused then
    return "focused"
  end

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if buffer.number == vim.api.nvim_win_get_buf(win) then
      return "visible"
    end
  end

  return "inactive"
end

return {
  "willothy/nvim-cokeline",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  opts = function()
    local get_hl_attr = require("cokeline.hlgroups").get_hl_attr

    local colors = {
      selected = function()
        return get_hl_attr("String", "fg")
      end,
      text = function()
        return get_hl_attr("Normal", "fg")
      end,
      subtle = function()
        return get_hl_attr("Comment", "fg")
      end,
      transparent = function()
        return "NONE"
      end,
      highlight = function()
        return get_hl_attr("CursorLine", "bg")
      end,
    }

    local hl = {
      focused = {
        fg = colors.selected,
        bg = colors.highlight,
        bold = true,
      },
      visible = {
        fg = colors.selected,
        bg = colors.transparent,
        bold = false,
      },
      inactive = {
        fg = colors.subtle,
        bg = colors.transparent,
        bold = false,
      },
    }

    local function hl_fg(buffer)
      local state = get_buffer_state(buffer)
      return hl[state].fg()
    end

    local function hl_bg(buffer)
      return hl[get_buffer_state(buffer)].bg()
    end

    local function hl_bold(buffer)
      return hl[get_buffer_state(buffer)].bold
    end

    return {
      history = {
        enabled = true,
        size = 100,
      },

      sidebar = {
        components = {
          {
            text = "NvimTree",
            fg = function(buffer)
              return buffer.is_focused and colors.text() or colors.subtle()
            end,
            bg = colors.transparent,
          },
        },
      },

      default_hl = {
        fg = hl_fg,
        bg = hl_bg,
        bold = hl_bold,
      },

      components = {
        -- separator
        {
          text = function(buffer)
            return buffer.is_first and "" or " ▏"
          end,
          fg = colors.text,
          bg = "NONE",
        },
        {
          text = function(buffer)
            return buffer.is_focused and "" or " "
          end,
          fg = colors.highlight,
          bg = "NONE",
        },
        -- devicon
        {
          text = function(buffer)
            return buffer.devicon.icon
          end,
          fg = function(buffer)
            return buffer.devicon.color
          end,
        },
        -- unique prefix
        {
          text = function(buffer)
            return buffer.unique_prefix
          end,
          italic = true,
        },
        -- filename
        {
          text = function(buffer)
            return buffer.filename .. " "
          end,
        },
        -- close button
        {
          text = function(buffer)
            return buffer.is_modified and " " or "󰖭 "
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
            return buffer.is_modified and "#00FFFF" or colors.text()
          end,
        },
        {
          text = function(buffer)
            return buffer.is_focused and "" or " "
          end,
          fg = colors.highlight,
          bg = colors.transparent,
        },
      },
      tabs = {
        placement = "left",
        components = {
          {
            text = function(tab)
              return tab.is_first and tab.is_last and "" or " " .. tab.number .. " "
            end,
            fg = function(tab)
              return tab.is_active and colors.text() or colors.subtle()
            end,
            bg = function(tab)
              return tab.is_active and colors.highlight() or colors.transparent()
            end,
          },
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
